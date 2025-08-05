class Admin::AdminController < ApplicationController
  before_action :require_admin
  
  def index
    @currencies = Currency.includes(:currency_denominations).all
    @denominations_without_images = CurrencyDenomination.left_joins(:obverse_image_attachment, :reverse_image_attachment)
                                                       .where(active_storage_attachments: { id: nil })
                                                       .distinct
  end
  
  def bulk_image_upload
    @denominations = CurrencyDenomination.includes(:currency).all
  end
  
  def process_bulk_upload
    denomination_id = params[:denomination_id]
    obverse_url = params[:obverse_url]
    reverse_url = params[:reverse_url]
    
    denomination = CurrencyDenomination.find(denomination_id)
    
    begin
      # Download and attach obverse image
      if obverse_url.present?
        downloaded_file = download_image(obverse_url)
        denomination.obverse_image.attach(
          io: downloaded_file,
          filename: "#{denomination.name.parameterize}-obverse.jpg",
          content_type: 'image/jpeg'
        )
      end
      
      # Download and attach reverse image
      if reverse_url.present?
        downloaded_file = download_image(reverse_url)
        denomination.reverse_image.attach(
          io: downloaded_file,
          filename: "#{denomination.name.parameterize}-reverse.jpg",
          content_type: 'image/jpeg'
        )
      end
      
      redirect_to admin_bulk_image_upload_path, notice: "Images uploaded successfully for #{denomination.name}"
    rescue => e
      redirect_to admin_bulk_image_upload_path, alert: "Error uploading images: #{e.message}"
    end
  end
  
  def image_management
    @denominations = CurrencyDenomination.includes(:currency).all
    @denominations_with_images = @denominations.select { |d| d.obverse_image.attached? || d.reverse_image.attached? }
    @denominations_without_images = @denominations.reject { |d| d.obverse_image.attached? || d.reverse_image.attached? }
  end
  
  def delete_image
    denomination = CurrencyDenomination.find(params[:id])
    image_type = params[:image_type]
    
    case image_type
    when 'obverse'
      denomination.obverse_image.purge if denomination.obverse_image.attached?
    when 'reverse'
      denomination.reverse_image.purge if denomination.reverse_image.attached?
    end
    
    redirect_to admin_image_management_path, notice: "#{image_type.capitalize} image deleted for #{denomination.name}"
  end
  
  private
  
  def require_admin
    # TODO: Implement proper admin authentication
    # For now, allow access in development and test environments
    unless Rails.env.development? || Rails.env.test?
      redirect_to root_path, alert: "Admin access required"
    end
  end
  
  def download_image(url)
    require 'open-uri'
    require 'tempfile'
    
    temp_file = Tempfile.new(['image', '.jpg'])
    temp_file.binmode
    temp_file.write(URI.open(url).read)
    temp_file.rewind
    temp_file
  end
end 
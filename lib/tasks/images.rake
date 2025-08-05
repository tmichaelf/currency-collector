namespace :images do
  desc "Download sample images for all US denominations"
  task download_sample_images: :environment do
    puts "Downloading sample images for US denominations..."
    
    # Sample image URLs for US currency (these would need to be replaced with actual URLs)
    sample_images = {
      'Penny' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/2009_Lincoln_penny_obverse.png/800px-2009_Lincoln_penny_obverse.png',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/2009_Lincoln_penny_reverse.png/800px-2009_Lincoln_penny_reverse.png'
      },
      'Nickel' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/2006_Jefferson_nickel_obverse.png/800px-2006_Jefferson_nickel_obverse.png',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/2006_Jefferson_nickel_reverse.png/800px-2006_Jefferson_nickel_reverse.png'
      },
      'Dime' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/2006_Roosevelt_dime_obverse.png/800px-2006_Roosevelt_dime_obverse.png',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/2006_Roosevelt_dime_reverse.png/800px-2006_Roosevelt_dime_reverse.png'
      },
      'Quarter' => {
        obverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/2006_Washington_quarter_obverse.png/800px-2006_Washington_quarter_obverse.png',
        reverse: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/2006_Washington_quarter_reverse.png/800px-2006_Washington_quarter_reverse.png'
      }
    }
    
    us_currency = Currency.find_by(code: 'USD')
    return puts "US Dollar currency not found!" unless us_currency
    
    sample_images.each do |denomination_name, urls|
      denomination = us_currency.currency_denominations.find_by(name: denomination_name)
      next unless denomination
      
      puts "Processing #{denomination.name}..."
      
      begin
        # Download obverse image
        if urls[:obverse]
          downloaded_file = download_image_from_url(urls[:obverse])
          denomination.obverse_image.attach(
            io: downloaded_file,
            filename: "#{denomination.name.parameterize}-obverse.jpg",
            content_type: 'image/jpeg'
          )
          puts "  ✓ Obverse image attached"
        end
        
        # Download reverse image
        if urls[:reverse]
          downloaded_file = download_image_from_url(urls[:reverse])
          denomination.reverse_image.attach(
            io: downloaded_file,
            filename: "#{denomination.name.parameterize}-reverse.jpg",
            content_type: 'image/jpeg'
          )
          puts "  ✓ Reverse image attached"
        end
        
      rescue => e
        puts "  ✗ Error processing #{denomination.name}: #{e.message}"
      end
    end
    
    puts "Sample image download complete!"
  end
  
  desc "List all denominations without images"
  task list_missing: :environment do
    puts "Denominations without images:"
    puts "=" * 50
    
    Currency.includes(:currency_denominations).each do |currency|
      puts "\n#{currency.name}:"
      currency.currency_denominations.each do |denomination|
        obverse = denomination.obverse_image.attached? ? "✓" : "✗"
        reverse = denomination.reverse_image.attached? ? "✓" : "✗"
        puts "  #{denomination.name}: Obverse #{obverse} | Reverse #{reverse}"
      end
    end
  end
  
  desc "Clean up orphaned images"
  task cleanup: :environment do
    puts "Cleaning up orphaned images..."
    
    # Find attachments without records
    orphaned_attachments = ActiveStorage::Attachment.left_joins(:record)
                                                   .where(records: { id: nil })
    
    if orphaned_attachments.any?
      puts "Found #{orphaned_attachments.count} orphaned attachments"
      orphaned_attachments.destroy_all
      puts "Orphaned attachments cleaned up"
    else
      puts "No orphaned attachments found"
    end
  end
  
  private
  
  def download_image_from_url(url)
    require 'open-uri'
    require 'tempfile'
    
    temp_file = Tempfile.new(['image', '.jpg'])
    temp_file.binmode
    temp_file.write(URI.open(url).read)
    temp_file.rewind
    temp_file
  end
end 
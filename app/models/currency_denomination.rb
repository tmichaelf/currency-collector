class CurrencyDenomination < ApplicationRecord
  belongs_to :currency
  has_many :currency_denomination_variants, dependent: :destroy
  has_many :currency_collections, through: :currency_denomination_variants
  
  has_one_attached :obverse_image
  has_one_attached :reverse_image
  
  validates :name, presence: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :denomination_type, presence: true, inclusion: { in: %w[coin bill] }
  # For base denomination, year fields no longer required; variants hold details
  validates :year_introduced, numericality: { greater_than: 0 }, allow_nil: true
  
  # Image validations - Active Storage handles content_type and size validation automatically
  # No additional validation needed as Active Storage provides built-in validation
  
  scope :active, -> { where(is_active: true) }
  scope :coins, -> { where(denomination_type: 'coin') }
  scope :bills, -> { where(denomination_type: 'bill') }
  
  def display_name
    "#{name} (#{value})"
  end
  
  def current?
    year_discontinued.nil?
  end
end

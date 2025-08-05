class CurrencyDenomination < ApplicationRecord
  belongs_to :currency
  has_many :currency_collections, dependent: :destroy
  
  validates :name, presence: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :denomination_type, presence: true, inclusion: { in: %w[coin bill] }
  validates :year_introduced, presence: true, numericality: { greater_than: 0 }
  
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

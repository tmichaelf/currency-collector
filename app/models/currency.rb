class Currency < ApplicationRecord
  has_many :currency_denominations, dependent: :destroy
  
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :country, presence: true
  
  scope :active, -> { where(is_active: true) }
  
  def display_name
    "#{name} (#{code})"
  end
end

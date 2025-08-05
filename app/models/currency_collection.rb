class CurrencyCollection < ApplicationRecord
  belongs_to :user
  belongs_to :currency_denomination
  
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :condition, presence: true, inclusion: { in: %w[mint uncirculated excellent very_good good fair poor] }
  validates :acquired_date, presence: true
  
  scope :by_condition, ->(condition) { where(condition: condition) }
  scope :recent, -> { where('acquired_date >= ?', 30.days.ago) }
  
  def total_value
    quantity * currency_denomination.value
  end
  
  def condition_display
    condition.humanize
  end
end

class CurrencyCollection < ApplicationRecord
  belongs_to :user
  belongs_to :currency_denomination, optional: true
  belongs_to :currency_denomination_variant, optional: true
  
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :condition, presence: true, inclusion: { in: %w[mint uncirculated excellent very_good good fair poor] }
  validates :acquired_date, presence: true
  
  scope :by_condition, ->(condition) { where(condition: condition) }
  scope :recent, -> { where('acquired_date >= ?', 30.days.ago) }
  
  def total_value
    base = currency_denomination || currency_denomination_variant&.currency_denomination
    quantity * (base&.value.to_f)
  end
  
  def condition_display
    condition.humanize
  end
end

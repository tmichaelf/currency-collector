class CurrencyDenominationVariant < ApplicationRecord
  belongs_to :currency_denomination
  has_many :currency_collections, dependent: :nullify

  validates :name, presence: true
  validates :year_introduced, numericality: { greater_than: 0 }, allow_nil: true
  validates :year_discontinued, numericality: { greater_than: 0 }, allow_nil: true

  scope :active, -> { where(is_active: true) }
end



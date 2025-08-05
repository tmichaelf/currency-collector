class CurrencyCardComponent < ViewComponent::Base
  def initialize(currency:)
    @currency = currency
  end

  private

  attr_reader :currency
end 
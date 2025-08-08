class CurrenciesController < ApplicationController
  def index
    # All active currencies
    @currencies = Currency.active.includes(:currency_denominations)
  end

  def show
    @currency = Currency.find_by(id: params[:id])
    @denominations = @currency.currency_denominations.active.includes(:currency_collections)

    @coin_denominations = @denominations.where(denomination_type: 'coin')
    @bill_denominations = @denominations.where(denomination_type: 'bill')
  end
end

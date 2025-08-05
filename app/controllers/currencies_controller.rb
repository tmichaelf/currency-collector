class CurrenciesController < ApplicationController
  def index
    @currencies = Currency.active.includes(:currency_denominations)
  end

  def show
    @currency = Currency.find_by(id: params[:id])
    @denominations = @currency.currency_denominations.active.includes(:currency_collections)
  end
end

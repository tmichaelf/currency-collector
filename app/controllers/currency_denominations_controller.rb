class CurrencyDenominationsController < ApplicationController
  def index
    @currency = Currency.find_by(id: params[:currency_id])
    @denominations = @currency.currency_denominations.active.includes(:currency_collections)
  end

  def show
    @denomination = CurrencyDenomination.find_by(id: params[:id])
    @collections = @denomination.currency_collections.includes(:user)
  end
end

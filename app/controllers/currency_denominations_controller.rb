class CurrencyDenominationsController < ApplicationController
  def index
    @currency = Currency.find_by(id: params[:currency_id])
    @denominations = @currency.currency_denominations.active.includes(:currency_collections)
  end

  def show
    @denomination = CurrencyDenomination.find_by(id: params[:id])
    @collections = @denomination.currency_collections.includes(:user)
  end

  def edit
    @denomination = CurrencyDenomination.find_by(id: params[:id])
  end

  def update
    @denomination = CurrencyDenomination.find_by(id: params[:id])
    if @denomination.update(denomination_params)
      redirect_to currency_currency_denomination_path(@denomination.currency, @denomination), notice: 'Denomination was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def denomination_params
    params.require(:currency_denomination).permit(:obverse_image, :reverse_image)
  end
end

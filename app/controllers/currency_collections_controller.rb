class CurrencyCollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  def index
    @collections = CurrencyCollection.includes(:user, :currency_denomination => :currency)
  end

  def show
  end

  def new
    @collection = CurrencyCollection.new
    @denominations = CurrencyDenomination.active.includes(:currency)
  end

  def create
    @collection = CurrencyCollection.new(collection_params)
    @collection.user = User.first # TODO: Replace with current_user when auth is added
    
    if @collection.save
      redirect_to @collection, notice: 'Collection item was successfully created.'
    else
      @denominations = CurrencyDenomination.active.includes(:currency)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @denominations = CurrencyDenomination.active.includes(:currency)
  end

  def update
    if @collection.update(collection_params)
      redirect_to @collection, notice: 'Collection item was successfully updated.'
    else
      @denominations = CurrencyDenomination.active.includes(:currency)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @collection.destroy
    redirect_to currency_collections_url, notice: 'Collection item was successfully deleted.'
  end

  private

  def set_collection
    @collection = CurrencyCollection.find_by(id: params[:id])
  end

  def collection_params
    params.require(:currency_collection).permit(:currency_denomination_id, :quantity, :condition, :notes, :acquired_date)
  end
end

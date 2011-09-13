class FuelPricesController < ApplicationController
  respond_to :html, :json

  def index
    @fuel_prices = FuelPrice.all
    respond_with(@fuel_prices)
  end
end

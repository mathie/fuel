class FuelPricesController < ApplicationController
  respond_to :html, :json

  def index
    @fuel_prices = FuelPrice.scoped
    respond_with(@fuel_prices)
  end

  def net_prices
    @fuel_prices = FuelPrice.scoped
    respond_with(@fuel_prices)
  end
end

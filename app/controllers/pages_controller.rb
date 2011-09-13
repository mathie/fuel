class PagesController < ApplicationController
  def index
    redirect_to fuel_prices_path if user_signed_in?
  end
end

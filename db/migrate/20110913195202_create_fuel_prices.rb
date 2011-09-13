class CreateFuelPrices < ActiveRecord::Migration
  def change
    create_table :fuel_prices do |t|
      t.date    :week_begins_on, null: false
      t.decimal :unleaded_price, null: false, precision: 16, scale: 8
      t.decimal :diesel_price,   null: false, precision: 16, scale: 8
    end
  end
end

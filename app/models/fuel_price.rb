class FuelPrice < ActiveRecord::Base
  validates :week_begins_on, presence: true
  validates :unleaded_price, presence: true, numericality: true
  validates :diesel_price,   presence: true, numericality: true

  def self.import(csv_file = Rails.root.join('db', 'fuel-prices.csv'))
    require 'csv'

    transaction do
      delete_all
      CSV.foreach(csv_file) do |row|
        date_string, _, unleaded_price, diesel_price, _, fuel_duty, _, _, vat_rate = row

        if date_string.present? && date_string =~ /^[0-9]+\/[0-9]+\/[0-9]+/
          create! week_begins_on: date_string, unleaded_price: unleaded_price, diesel_price: diesel_price
        end
      end
    end
  end
end

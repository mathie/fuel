class FuelPrice < ActiveRecord::Base
  validates :week_begins_on, presence: true
  validates :unleaded_price, presence: true, numericality: true
  validates :diesel_price,   presence: true, numericality: true

  def self.import(csv_file = Rails.root.join('db', 'fuel-prices.csv'))
    require 'csv'

    transaction do
      delete_all
      CSV.foreach(csv_file) do |row|
        date_string, unleaded_price, diesel_price, _ = row

        if date_string.present? && date_string =~ /^[0-9]+\/[0-9]+\/[0-9]+/
          create!(
            week_begins_on: date_string,
            unleaded_price: BigDecimal(unleaded_price) / BigDecimal('100'),
            diesel_price: BigDecimal(diesel_price) / BigDecimal('100')
          )
        end
      end
    end
  end

  def as_json(options = {})
    super({
      :methods => [
        :unleaded_price_without_vat,
        :diesel_price_without_vat,
        :unleaded_net_price,
        :diesel_net_price,
        :fuel_duty,
        :diesel_unleaded_differential
      ]
    }.merge(options || {}))
  end

  def diesel_unleaded_differential
    diesel_price - unleaded_price
  end

  def unleaded_price_without_vat
    (gross_fraction * unleaded_price).round(4)
  end

  def diesel_price_without_vat
    (gross_fraction * diesel_price).round(4)
  end

  def unleaded_net_price
    unleaded_price_without_vat - fuel_duty
  end

  def diesel_net_price
    diesel_price_without_vat - fuel_duty
  end

  def fuel_duty
    FuelDuty.at(week_begins_on).duty_rate_per_litre
  end

  private
  def gross_fraction
    VatRate.at(week_begins_on).gross_fraction
  end
end

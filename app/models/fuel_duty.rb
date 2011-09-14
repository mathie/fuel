class FuelDuty
  def self.fuel_duties
    @fuel_duties ||= [
      FuelDuty.new(nil,                    Date.new(2003,  9, 30), BigDecimal('0.4582')),
      FuelDuty.new(Date.new(2003, 10,  1), Date.new(2006, 12,  6), BigDecimal('0.4710')),
      FuelDuty.new(Date.new(2006, 12,  7), Date.new(2007,  9, 30), BigDecimal('0.4835')),
      FuelDuty.new(Date.new(2007, 10,  1), Date.new(2008, 11, 30), BigDecimal('0.5035')),
      FuelDuty.new(Date.new(2008, 12,  1), Date.new(2009,  3, 31), BigDecimal('0.5235')),
      FuelDuty.new(Date.new(2009,  4,  1), Date.new(2009,  8, 31), BigDecimal('0.5419')),
      FuelDuty.new(Date.new(2009,  9,  1), Date.new(2010,  3, 31), BigDecimal('0.5619')),
      FuelDuty.new(Date.new(2010,  4,  1), Date.new(2010,  9, 30), BigDecimal('0.5719')),
      FuelDuty.new(Date.new(2010, 10,  1), Date.new(2011, 12, 31), BigDecimal('0.5819')),
      FuelDuty.new(Date.new(2011,  1,  1), Date.new(2011,  3, 22), BigDecimal('0.5895')),
      FuelDuty.new(Date.new(2011,  3, 23), nil,                    BigDecimal('0.5795')),
    ]
  end

  def self.at(date)
    fuel_duties.find { |fuel_duty| fuel_duty.rate_on?(date) }
  end

  attr_reader :duty_rate_per_litre

  def initialize(starts_on, ends_on, duty_rate_per_litre)
    @starts_on           = starts_on
    @ends_on             = ends_on
    @duty_rate_per_litre = duty_rate_per_litre
  end

  def rate_on?(date)
    if @starts_on.blank?
      date <= @ends_on
    elsif @ends_on.blank?
      date >= @starts_on
    else
      date >= @starts_on && date <= @ends_on
    end
  end
end

class VatRate
  def self.vat_rates
    @vat_rates ||= [
      VatRate.new(nil,                   Date.new(2008, 11, 30), BigDecimal('17.5')),
      VatRate.new(Date.new(2008, 12, 1), Date.new(2009, 12, 31), BigDecimal('15.0')),
      VatRate.new(Date.new(2010,  1, 1), Date.new(2011,  1,  3), BigDecimal('17.5')),
      VatRate.new(Date.new(2011,  1, 4), nil,                    BigDecimal('20.0'))
    ]
  end

  def self.at(date)
    vat_rates.find { |vat_rate| vat_rate.rate_on?(date) }
  end

  attr_reader :percentage

  def initialize(starts_on, ends_on, percentage)
    @starts_on  = starts_on
    @ends_on    = ends_on
    @percentage = percentage
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

  def gross_fraction
    (1 / (1 + multiplier))
  end

  def vat_fraction
    1 - gross_fraction
  end

  def multiplier
    percentage / 100
  end
end
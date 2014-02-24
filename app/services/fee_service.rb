class FeeService

  def initialize(amount, time = Time.zone.now)
    @time = time
    @amount = BigDecimal(amount)
    @fee = BigDecimal(5)
  end

  def calculate

    hour = @time.hour
    amount = @amount

    @fee = 7 if hour > 18 || hour < 9  || (@time.saturday? || @time.sunday?)
    @fee += 10 if amount > BigDecimal(1000)

    @fee

  end

end
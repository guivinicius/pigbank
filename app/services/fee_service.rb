class FeeService

  def initialize(user, time, amount)
    @user = user
    @time = time
    @amount = amount
    @fee = BigDecimal(5)
  end

  def charge!

    ActiveRecord::Base.transaction do
      DebitService.new(@user, @fee, "Transference Fee").debit!
    end

  end

  def calculate

    hour = @time.hour
    amount = @amount

    @fee = 7 if hour > 18 || hour < 9  || (@time.saturday? || @time.sunday?)
    @fee += 10 if amount > BigDecimal(1000)

    @fee

  end

end
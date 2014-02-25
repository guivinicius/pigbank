class CreditService

  def initialize(credit)
    @credit = credit
  end

  def credit!

    ActiveRecord::Base.transaction do
      @credit.save

      account = @credit.user.account
      account.increment!(:balance, @credit.amount)
    end if @credit.valid?

  end

end
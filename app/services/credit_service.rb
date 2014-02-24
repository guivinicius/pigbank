class CreditService

  def initialize(user, amount, description = "Credit")
    @amount = amount
    @credit = Credit.new(:user => user, :amount => @amount, :activity_type => 0, :description => description)

    valid?
  end

  def credit!

    ActiveRecord::Base.transaction do
      @credit.save
      @credit.user.account.increment!(:balance, @credit.amount)
    end if valid?

    @credit
  end

  def valid?
    @credit.valid?
  end

  def errors
    @credit.errors
  end

end
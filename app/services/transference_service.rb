class TransferenceService

  def initialize(from, to, amount, description = "Online transfer")

    @from_user = from
    @to_user = to
    @amount = BigDecimal(amount)
    @description = description

    @transference = Transference.new(:from_user => @from_user, :to_user => @to_user, :amount => @amount)
    @transference.valid?

    has_enought_balance?
    same_user?
  end

  def transfer!

    ActiveRecord::Base.transaction do
      @transference.save

      # Debiting the amout and fee from_user
      DebitService.new(@from_user, @amount, @description).debit!
      fee = FeeService.new(@amount, @transference.created_at).calculate
      DebitService.new(@from_user, fee, "Transference Fee").debit!

      # Crediting the amount in to_user
      CreditService.new(@to_user, @amount, @description).credit!

    end if valid?

    @transference
  end

  def valid?
    errors.size == 0
  end

  def errors
    @transference.errors
  end

  private

  def has_enought_balance?

    fee = FeeService.new(@amount, Time.zone.now).calculate

    if (@amount + fee) > @from_user.balance
      errors.add(:balance, "is not enought.")
    end

  end

  def same_user?
    errors.add(:account, "You can't make a transference to you own account.") if @from_user == @to_user
  end

end
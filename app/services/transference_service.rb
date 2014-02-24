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
      DebitService.new(@from_user, @amount, @description).debit!
      CreditService.new(@to_user, @amount, @description).credit!
      FeeService.new(@from_user, @transference.created_at, @amount).charge!
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

    if (@amount + FeeService.new(@from_user, Time.zone.now, @amount).calculate) > @from_user.balance
      errors.add(:balance, "is not enought.")
    end

  end

  def same_user?
    errors.add(:account, "You can't make a transference to you own account.") if @from_user == @to_user
  end

end
class DebitService

  def initialize(debit)
    @debit = debit
    @user = @debit.user
  end

  def debit!

    ActiveRecord::Base.transaction do
      @debit.save

      account = @user.account
      account.decrement!(:balance, @debit.amount)
    end if @debit.valid?

  end

  def debit_with_password!(password)

    if @user.valid_password?(password)
      debit!
    else
      @debit.errors.add(:password, "is wrong.")

      false
    end

  end

end
class DebitService

  def initialize(user, amount, description = "Debit", password = "")
    @user = user
    @amount = amount
    @password = password

    @debit = Debit.new(:user => @user, :amount => @amount, :activity_type => 1, :description => description)
    @debit.valid?

    validate_password if @password.present?
  end

  def debit!

    ActiveRecord::Base.transaction do
      @debit.save
      @debit.user.account.decrement!(:balance, @debit.amount)
    end if valid?

    @debit
  end

  def valid?
    errors.size == 0
  end

  def errors
    @debit.errors
  end

  private

  def validate_password
    errors.add(:password, "is wrong.") if !@user.valid_password?(@password)
  end


end
class TransferenceService

  def initialize(transference)
    @transference = transference
  end

  def transfer!

    ActiveRecord::Base.transaction do
      @transference.save

      amount = @transference.amount
      from_user = @transference.from_user
      to_user = @transference.to_user

      # Debiting amount
      amount_debit = Debit.new(:user => from_user, :activity_type => 1, :amount => amount, :description => "Online Transfer")
      DebitService.new(amount_debit).debit!

      # Crediting amount
      amount_credit = Credit.new(:user => to_user, :activity_type => 0, :amount => amount, :description => "Online Transfer")
      CreditService.new(amount_credit).credit!

      # Debiting fee
      fee = FeeService.new(amount, @transference.created_at).calculate
      fee_debit = Debit.new(:user => from_user, :activity_type => 1, :amount => fee, :description => "Transference Fee")
      DebitService.new(fee_debit).debit!

    end if @transference.valid?

  end

end
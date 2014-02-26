class ReceiptPresenter

  def initialize(obj)
    @obj = obj
  end

  def id
    @obj.id
  end

  def description
    if @obj.is_a?(Transference)
      "Online Transfer"
    else
      @obj.description
    end
  end

  def user_name
    user.name
  end

  def user_uid
    user.uid
  end

  def user_balance
    user.balance
  end

  def account_agency
    user.account.agency
  end

  def account_number
    user.account.number
  end

  def amount
    @obj.amount
  end

  def created_at
    @obj.created_at
  end

  private

  def user
    if @obj.is_a?(Transference)
      @obj.to_user
    else
      @obj.user
    end
  end

end
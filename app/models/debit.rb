# == Schema Information
#
# Table name: transactions
#
#  id            :integer          not null, primary key
#  activity_type :integer          not null
#  amount        :decimal(10, 2)   default(0.0), not null
#  user_id       :integer          not null
#  description   :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_transactions_on_user_id  (user_id)
#

class Debit < Transaction

  validates :amount,
    :numericality => { :less_than_or_equal_to => :current_user_balance }

  after_commit :update_user_balance,
    :on => :create

  private

  def current_user_balance
    user.balance
  end

  def update_user_balance
    user.decrement!(:balance, amount)
  end

end

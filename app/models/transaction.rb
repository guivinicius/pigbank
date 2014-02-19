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

class Transaction < ActiveRecord::Base

  ACTIVITY_TYPES = { :credit => 0, :debit => 1 }

  validates :activity_type, :amount, :user_id,
    :presence => true

  belongs_to :user

  after_commit :update_user_balance,
    :on => :create

  private

  def update_user_balance

    case activity_type
      when ACTIVITY_TYPES[:credit]
        user.update_attribute(:balance, user.balance + amount)
      when ACTIVITY_TYPES[:debit]
        user.update_attribute(:balance, user.balance - amount)
    end

  end

end

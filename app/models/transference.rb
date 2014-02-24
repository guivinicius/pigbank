# == Schema Information
#
# Table name: transferences
#
#  id           :integer          not null, primary key
#  from_user_id :integer          not null
#  to_user_id   :integer          not null
#  amount       :decimal(10, 2)   default(0.0), not null
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_transferences_on_from_user_id  (from_user_id)
#  index_transferences_on_to_user_id    (to_user_id)
#

class Transference < ActiveRecord::Base

  validates :from_user_id, :to_user_id, :amount,
    :presence => true

  validates :amount,
    :numericality => { :greater_than => 0, :less_than_or_equal_to => :from_user_balance }

  belongs_to :from_user,
    :class_name => "User"

  belongs_to :to_user,
    :class_name => "User"

  private

  def from_user_balance
    from_user.balance
  end

end

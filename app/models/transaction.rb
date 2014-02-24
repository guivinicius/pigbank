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

  validates :activity_type, :amount, :user_id,
    :presence => true

  validates :amount,
    :numericality => { :greater_than => 0 }

  scope :credits, -> { where(:activity_type => 0) }
  scope :debits, -> { where(:activity_type => 1) }

  belongs_to :user

  def self.created_between(start_date = "" , end_date = "")
    start_date = Date.current - 30.days if start_date.empty?
    end_date = Date.current if end_date.empty?
    where(:created_at => Time.zone.parse("#{start_date} 00:00:00")..Time.zone.parse("#{end_date} 23:59:59"))
  end

  def is_credit?
    activity_type == 0
  end

  def is_debit?
    activity_type == 1
  end

end

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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    activity_type 0
    amount 10
    user_id 1
    description ""
    created_at Time.now

    trait :credit do
      activity_type 0
      description "Deposit"
    end

    trait :debit do
      activity_type 1
      description "Withdraw"
    end

    factory :credit_transaction, :traits => [:credit]
    factory :debit_transaction, :traits => [:debit]
  end
end

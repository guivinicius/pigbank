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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transference do
    from_user_id 1
    to_user_id 1
    amount 10
    created_at Time.zone.now
  end
end

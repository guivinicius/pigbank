FactoryGirl.define do
  factory :debit do
    activity_type 1
    amount 1
    user_id 1
    description ""
    created_at Time.zone.now
  end
end

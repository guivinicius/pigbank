FactoryGirl.define do
  factory :credit do
    activity_type 0
    amount 1
    user_id 1
    description ""
    created_at Time.zone.now
  end
end

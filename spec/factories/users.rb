# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  balance                :decimal(10, 2)   default(0.0)
#  agency_number          :integer
#  account_number         :integer
#  uid                    :string(255)
#  name                   :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid                   (uid) UNIQUE
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Guilherme Vinicius Moreira"
    sequence(:uid, 1) { |n| "33224411#{n}" }
    sequence(:email, 1) { |n| "person#{n}@example.com" }
    sequence(:agency_number, 1) { |n| "2233#{n}" }
    sequence(:account_number, 1) { |n| "32123#{n}" }
    password "12345678"
    password_confirmation "12345678"
    balance 100
  end
end

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

require 'spec_helper'

describe Transference do

  let(:user_1) { create(:user) }
  let(:account_1) { user_1.account }

  let(:user_2) { create(:user) }
  let(:account_2) { user_2.account }

  let(:transference) { build(:transference, :from_user => user_1, :to_user => user_2, :amount => 50) }

  before do
    account_1.balance = 100
    account_1.save

    account_2.balance = 100
    account_2.save
  end

  it 'is valid with valid attributes' do
    expect(transference).to be_valid
  end

end

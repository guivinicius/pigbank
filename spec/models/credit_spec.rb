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

require 'spec_helper'

describe Credit do

  let(:user) { create(:user) }
  let(:credit) { build(:credit, :user_id => user.id) }

  it 'is valid with valid attributes' do
    expect(credit).to be_valid
  end

end

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

describe Debit do

  let(:user) { create(:user, :balance => 100.00) }
  let(:debit) { build(:debit, :user_id => user.id) }

  it 'is valid with valid attributes' do
    debit.should be_valid
  end

  it "does not allow amount higher than user balance" do
    debit.amount = 200
    debit.save

    expect(debit).to have(1).error_on(:amount)
  end

end

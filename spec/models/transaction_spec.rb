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

describe Transaction do

  let(:user) { create(:user, :balance => 100.00) }
  let(:transaction) { build(:transaction, :user_id => user.id) }

  it 'is valid with valid attributes' do
    transaction.should be_valid
  end

  # Still needs to figure out how to test after_commit
  #
  # describe "#update_user_balance" do
  #   context "as debit" do

  #     it "subtracts the user balance by 20" do

  #       transaction.activity_type = 1
  #       transaction.amount = 20
  #       transaction.save

  #       expect(user.balance).to eq(BigDecimal(80))
  #     end

  #   end

  #   context "as credit" do

  #   end

  # end

end

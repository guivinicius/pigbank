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

  let(:user) { create(:user) }
  let(:account) { user.account }

  let(:transaction) { build(:transaction, :user_id => user.id) }
  let(:transaction2) { build(:transaction, :user_id => user.id, :created_at => Time.zone.now - 10.days) }

  before do
    account.balance = 100
    account.save
  end

  it 'is valid with valid attributes' do
    transaction.should be_valid
  end

  describe "amount validation" do

    it "allows amount higher than 0" do
      transaction.amount = 10
      transaction.save

      expect(transaction).to have(0).errors_on(:amount)
    end

    it "does not allows amount less than or equal 0" do
      transaction.amount = 0
      transaction.save

      expect(transaction).to have(1).errors_on(:amount)
    end

  end

  describe ".created_between" do

    context "when pass no arguments" do

      it "returns all transactions" do
        transaction.save
        transaction2.save

        expect(Transaction.created_between.size).to eql(2)
      end

    end

    context "when pass arguments" do

      it "returns only 1 transaction" do
        transaction.save
        transaction2.save

        start_date = (Date.current - 2.days).to_s
        end_date = Date.current.to_s

        expect(Transaction.created_between(start_date, end_date).size).to eql(1)
      end

    end

  end

  describe "#is_debit?" do

    context "when activity_type is 1" do

      it "returns true" do
        transaction.activity_type = 1
        expect(transaction.is_debit?).to eq(true)
      end

    end

    context "when activity_type is 0" do

      it "returns true" do
        transaction.activity_type = 0
        expect(transaction.is_debit?).to eq(false)
      end

    end

  end

  describe "#is_credit?" do

    context "when activity_type is 0" do

      it "returns true" do
        transaction.activity_type = 0
        expect(transaction.is_credit?).to eq(true)
      end

    end

    context "when activity_type is 1" do

      it "returns true" do
        transaction.activity_type = 1
        expect(transaction.is_credit?).to eq(false)
      end

    end

  end

end

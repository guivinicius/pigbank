require "spec_helper"

describe CreditService do

  let(:user) { create(:user) }
  let(:account) { user.account }

  let(:valid_credit_service) { CreditService.new(build(:credit, :amount => 10, :user => user)) }
  let(:invalid_credit_service) { CreditService.new(build(:credit, :amount => 0, :user => user)) }

  describe "#credit!" do

    context "when attributes are valid" do

      it "creates a new transaction" do
        expect {
          valid_credit_service.credit!
        }.to change(Transaction, :count).by(1)
      end

      it "increment user balance" do
        expect {
          valid_credit_service.credit!
        }.to change { user.balance }.by(10)
      end

    end

    context "when attributes are not valid" do

      it "creates a new transaction" do
        expect {
          invalid_credit_service.credit!
        }.not_to change(Transaction, :count).by(1)
      end

      it "dont increment user balance" do
        expect {
          invalid_credit_service.credit!
        }.not_to change { user.balance }
      end

    end

  end

end
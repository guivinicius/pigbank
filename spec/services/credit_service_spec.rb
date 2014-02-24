require "spec_helper"

describe CreditService do

  let(:user) { create(:user) }
  let(:amount) { 100 }

  let(:valid_credit_service) { CreditService.new(user, amount) }
  let(:invalid_credit_service) { CreditService.new(user, 0) }

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
        }.to change { user.balance }.by(100)
      end

      it "returns a instance of Credit" do
        expect(valid_credit_service.credit!).to be_a(Credit)
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

      it "returns a instance of Credit" do
        expect(invalid_credit_service.credit!).to be_a(Credit)
      end

    end

  end

  describe "#valid?" do
    context "when attributes are valid" do

      it "returns true" do
        expect(valid_credit_service.valid?).to eql(true)
      end

    end

    context "when attributes are not valid" do

      it "returns false" do
        expect(invalid_credit_service.valid?).to eql(false)
      end

    end
  end

  describe "#errors?" do

    context "when attributes are valid" do
      it "returns a empty array" do
        expect(valid_credit_service.errors).not_to have(1).error_on(:amount)
      end
    end

    context "when attributes are not valid" do
      it "returns a arrays with errors" do
        expect(invalid_credit_service.errors).to have(1).error_on(:amount)
      end
    end
  end

end
require "spec_helper"

describe TransferenceService do

  let(:user_1) { create(:user) }
  let(:account_1) { user_1.account }

  let(:user_2) { create(:user) }
  let(:account_2) { user_2.account }

  let(:valid_transference_service) { TransferenceService.new(user_1, user_2, 100) }
  let(:invalid_transference_service) { TransferenceService.new(user_1, user_2, 0) }

  before do
    account_1.balance = 200
    account_1.save

    account_2.balance = 200
    account_2.save
  end

  describe "#transfer!" do

    context "when attributes are valid" do

      it "creates a new Transference" do
        expect {
          valid_transference_service.transfer!
        }.to change(Transference, :count).by(1)
      end

      it "creates a new Credit" do
        expect {
          valid_transference_service.transfer!
        }.to change(Transaction.credits, :count).by(1)
      end

      it "creates 2 new Debits" do
        expect {
          valid_transference_service.transfer!
        }.to change(Transaction.debits, :count).by(2)
      end

      it "decrements user_1 balance" do
        expect {
          valid_transference_service.transfer!
        }.to change{ user_1.balance }
      end

      it "increments user_2 balance" do
        expect {
          valid_transference_service.transfer!
        }.to change{ user_2.balance }.by(100)
      end

    end

    context "when attributes are not valid" do

      it "don't create a new Transference" do
        expect {
          invalid_transference_service.transfer!
        }.not_to change(Transference, :count)
      end

      it "don't create a new Credit" do
        expect {
          invalid_transference_service.transfer!
        }.not_to change(Transaction.credits, :count)
      end

      it "don't create Debits" do
        expect {
          invalid_transference_service.transfer!
        }.not_to change(Transaction.debits, :count)
      end

    end

  end

  describe "#valid?" do
    context "when attributes are valid" do

      it "returns true" do
        expect(valid_transference_service.valid?).to eql(true)
      end

    end

    context "when attributes are not valid" do

      it "returns false" do
        expect(invalid_transference_service.valid?).to eql(false)
      end

    end
  end

  describe "#errors?" do

    it "does something" do

    end
    context "when attributes are valid" do
      it "returns a empty array" do
        expect(valid_transference_service.errors).not_to have(1).error_on(:amount)
      end
    end

    context "when attributes are not valid" do
      it "returns a arrays with errors" do
        expect(invalid_transference_service.errors).to have(1).error_on(:amount)
      end
    end
  end

  describe "#has_enought_balance?" do

    it "adds a error on balance" do
      account_1.balance = 100
      account_1.save

      expect(valid_transference_service.errors).to have(1).error_on(:balance)
    end

  end

end
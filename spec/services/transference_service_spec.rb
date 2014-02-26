require "spec_helper"

describe TransferenceService do

  let(:user_1) { create(:user) }
  let(:account_1) { user_1.account }

  let(:user_2) { create(:user) }
  let(:account_2) { user_2.account }

  let(:valid_transference) { build(:transference, :from_user => user_1, :to_user => user_2, :amount => 100) }
  let(:invalid_transference) { build(:transference, :from_user => user_1, :to_user => user_2, :amount => 0) }

  let(:valid_transference_service) { TransferenceService.new(valid_transference) }
  let(:invalid_transference_service) { TransferenceService.new(invalid_transference) }

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

end
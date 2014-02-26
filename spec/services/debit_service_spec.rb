require "spec_helper"

describe DebitService do

  let(:user) { create(:user) }
  let(:account) { user.account }

  let(:valid_debit_service) { DebitService.new(build(:debit, :user => user, :amount => 100)) }
  let(:invalid_debit_service) { DebitService.new(build(:debit, :user => user, :amount => 0)) }

  before do
    account.balance = 200
    account.save
  end

  describe "#debit!" do

    context "when attributes are valid" do

      it "creates a new transaction" do
        expect {
          valid_debit_service.debit!
        }.to change(Transaction, :count).by(1)
      end

      it "decrement user balance" do
        expect {
          valid_debit_service.debit!
        }.to change { user.balance }.from(200).to(100)
      end

    end

    context "when attributes are not valid" do

      it "creates a new transaction" do
        expect {
          invalid_debit_service.debit!
        }.not_to change(Transaction, :count).by(1)
      end

      it "dont decrement user balance" do
        expect {
          invalid_debit_service.debit!
        }.not_to change { user.balance }
      end

    end

  end

  describe "#debit_with_password!" do

    context 'when password is valid' do

      it "creates a new transaction" do
        expect {
          valid_debit_service.debit_with_password!(user.password)
        }.to change(Transaction, :count).by(1)
      end

      it "decrement user balance" do
        expect {
          valid_debit_service.debit_with_password!(user.password)
        }.to change { user.balance }.from(200).to(100)
      end

    end

    context 'when password is invalid' do

      it "creates a new transaction" do
        expect {
          invalid_debit_service.debit_with_password!("wrong!")
        }.not_to change(Transaction, :count).by(1)
      end

      it "dont decrement user balance" do
        expect {
          invalid_debit_service.debit_with_password!("wrong!")
        }.not_to change { user.balance }
      end

    end

  end

end
require "spec_helper"

describe ReceiptPresenter do

  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }

  let(:transference) { create(:transference, :from_user => user_1, :to_user => user_2) }
  let(:credit) { create(:credit, :user => user_1) }

  describe "#id" do

    it "returns the object id" do
      expect(ReceiptPresenter.new(credit).id).to eq(credit.id)
    end

  end

  describe "#description" do

    context "when passing a Transference object" do
      it "returns 'Online Transfer' " do
        expect(ReceiptPresenter.new(transference).description).to eq("Online Transfer")
      end

    end

    context "when passing a Transaction (credit or debit) object" do
      it "returns object description " do
        expect(ReceiptPresenter.new(credit).description).to eq(credit.description)
      end

    end

  end

  describe "#user_name" do
    context "when passing a Transference object" do

      it "returns Transference to_user name " do
        expect(ReceiptPresenter.new(transference).user_name).to eq(user_2.name)
      end

    end

    context "when passing a Transaction (credit or debit) object" do

      it "returns object user name" do
        expect(ReceiptPresenter.new(credit).user_name).to eq(user_1.name)
      end

    end
  end

  describe "#user_uid" do
    context "when passing a Transference object" do

      it "returns Transference to_user uid " do
        expect(ReceiptPresenter.new(transference).user_uid).to eq(user_2.uid)
      end

    end

    context "when passing a Transaction (credit or debit) object" do

      it "returns object user uid" do
        expect(ReceiptPresenter.new(credit).user_uid).to eq(user_1.uid)
      end

    end
  end

  describe "#user_balance" do
    context "when passing a Transference object" do

      it "returns Transference to_user balance " do
        expect(ReceiptPresenter.new(transference).user_balance).to eq(user_2.balance)
      end

    end

    context "when passing a Transaction (credit or debit) object" do

      it "returns object user balance" do
        expect(ReceiptPresenter.new(credit).user_balance).to eq(user_1.balance)
      end

    end
  end

  describe "#account_agency" do
    context "when passing a Transference object" do

      it "returns Transference to_user account agency " do
        expect(ReceiptPresenter.new(transference).account_agency).to eq(user_2.account.agency)
      end

    end

    context "when passing a Transaction (credit or debit) object" do

      it "returns object user account agency" do
        expect(ReceiptPresenter.new(credit).account_agency).to eq(user_1.account.agency)
      end

    end
  end

  describe "#account_number" do
    context "when passing a Transference object" do

      it "returns Transference to_user account number " do
        expect(ReceiptPresenter.new(transference).account_number).to eq(user_2.account.number)
      end

    end

    context "when passing a Transaction (credit or debit) object" do

      it "returns object user account number" do
        expect(ReceiptPresenter.new(credit).account_number).to eq(user_1.account.number)
      end

    end
  end

  describe "#amount" do
    it "returns the object amount" do
      expect(ReceiptPresenter.new(credit).amount).to eq(credit.amount)
    end
  end

  describe "#created_at" do
    it "returns the object created_at" do
      expect(ReceiptPresenter.new(credit).created_at).to eq(credit.created_at)
    end
  end

end
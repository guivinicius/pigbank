require "spec_helper"

describe DebitService do

  let(:user) { create(:user, :balance => 200) }
  let(:amount) { 100 }

  let(:valid_debit_service) { DebitService.new(user, amount) }
  let(:invalid_debit_service) { DebitService.new(user, 0) }

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

      it "returns a instance of Debit" do
        expect(valid_debit_service.debit!).to be_a(Debit)
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

      it "returns a instance of Debit" do
        expect(invalid_debit_service.debit!).to be_a(Debit)
      end

    end

  end

  describe "#valid?" do
    context "when attributes are valid" do

      it "returns true" do
        expect(valid_debit_service.valid?).to eql(true)
      end

    end

    context "when attributes are not valid" do

      it "returns false" do
        expect(invalid_debit_service.valid?).to eql(false)
      end

    end
  end

  describe "#errors?" do

    it "does something" do

    end
    context "when attributes are valid" do
      it "returns a empty array" do
        expect(valid_debit_service.errors).not_to have(1).error_on(:amount)
      end
    end

    context "when attributes are not valid" do
      it "returns a arrays with errors" do
        expect(invalid_debit_service.errors).to have(1).error_on(:amount)
      end
    end
  end

  describe "#validate_password" do
    context "when password is wrong" do
      it "adds a error to password" do
        expect(DebitService.new(user, 10, nil, "wrong").errors).to have(1).error_on(:password)
      end
    end

    context "when password is right" do
      it "doesn't adds error to password" do
        expect(DebitService.new(user, 10, nil, user.password).errors).not_to have(1).error_on(:password)
      end
    end
  end

end
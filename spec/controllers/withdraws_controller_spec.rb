require 'spec_helper'

describe WithdrawsController do

  login_user
  let(:account) { @user.account }

  let(:params) { {:debit => {:amount => BigDecimal(100) }} }
  let(:withdraw) { create(:debit, :user => @user, :amount => 10) }

  describe "GET 'show'" do

    before do
      account.balance = 100
      account.save
      get :show, :id => withdraw.id
    end

    it "returns http success" do
      expect(response.status).to eq(200)
    end

    it "assigns @receipt" do
      expect(assigns(:receipt)).to be_kind_of(ReceiptPresenter)
    end

    it "renders new template" do
      expect(response).to render_template("show")
    end

  end

  describe "GET 'new'" do

    before do
      get :new
    end

    it "returns http success" do
      expect(response.status).to eq(200)
    end

    it "assigns @withdraw" do
      expect(assigns(:withdraw)).to be_a_new(Debit)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

  end

  describe "POST 'check'" do

    context "with amount less than user balance" do

      before do
        account.balance = 1000.00
        account.save
      end

      it "returns http success" do
        post :check, params
        expect(response.status).to eq(200)
      end

      it "renders the check template" do
        post :check, params
        expect(response).to render_template("check")
      end

    end

    context "with amount higher than user balance" do

      it "redirects to Withdraw new" do
        account.balance = 10.00
        account.save
        post :check, params
        expect(response).to redirect_to(new_withdraw_path)
      end

    end

  end

  describe "POST 'create'" do

    before do
      account.balance = 1000.00
      account.save
    end

    context "with right password" do

      it "creates a new debit" do
        expect {
          post :create, params.merge({:password => @user.password})
        }.to change(Debit, :count).by(1)
      end

      it "redirects to Withdraw" do
        post :create, params.merge({:password => @user.password})
        expect(response).to redirect_to(withdraw_path(Debit.last))
      end

      context "with amount of 0" do
        it "renders the new template" do
          params[:debit][:amount] = BigDecimal(0)

          post :create, params.merge({:password => @user.password})
          expect(response).to redirect_to(new_withdraw_path)
        end
      end

    end

    context "with wrong password" do

      it "don't create a new debit" do
        expect {
          post :create, params.merge({:password => "112"})
        }.not_to change(Debit, :count)
      end

      it "redirects to Withdraw new" do
        post :create, params.merge({:password => "112"})
        expect(response).to redirect_to(new_withdraw_path)
      end

    end

  end

end

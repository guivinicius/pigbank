require 'spec_helper'

describe WithdrawsController do

  login_user
  let(:params) { {:transaction => {:amount => BigDecimal(100) }} }

  describe "GET 'new'" do

    before do
      get :new
    end

    it "returns http success" do
      expect(response.status).to eq(200)
    end

    it "assigns @withdraw" do
      expect(assigns(:withdraw)).to be_a_new(Transaction).with(:activity_type => 1)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

  end

  describe "POST 'check'" do

    it "returns http success" do
      post :check, params
      expect(response.status).to eq(200)
    end

    context "with amount lesser than user balance" do

      it "renders the check template" do
        @user.balance = 1000.00
        @user.save
        post :check, params
        expect(response).to render_template("check")
      end

    end

    context "with amount higher than user balance" do

      it "renders the new template" do
        @user.balance = 10.00
        @user.save
        post :check, params
        expect(response).to render_template("new")
      end

    end

  end

  describe "POST 'create'" do

    before do
      @user.balance = 1000.00
      @user.save
    end

    it "returns http success" do
      post :create, params.merge({:password => @user.password})
      expect(response.status).to eq(200)
    end

    context "with right password" do

      it "creates a new transaction" do
        expect {
          post :create, params.merge({:password => @user.password})
        }.to change(Transaction, :count).by(1)
      end

      it "renders create template" do
        post :create, params.merge({:password => @user.password})
        expect(response).to render_template("create")
      end

    end

    context "with wrong password" do

      it "creates a new transaction" do
        expect {
          post :create, params.merge({:password => "112"})
        }.not_to change(Transaction, :count).by(1)
      end

      it "renders create template" do
        post :create, params.merge({:password => "112"})
        expect(response).to render_template("check")
      end

    end

    context "with amount of 0" do
      it "renders the new template" do
        params[:transaction][:amount] = BigDecimal(0)

        post :create, params.merge({:password => @user.password})
        expect(response).to render_template("new")
      end
    end

  end

end

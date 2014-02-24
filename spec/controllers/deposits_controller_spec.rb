require 'spec_helper'

describe DepositsController do

  let(:user) { create(:user) }
  let(:account) { user.account }

  let(:valid_params) { { :account => {:agency => account.agency.to_s, :number => account.number.to_s}, :credit => { :amount => BigDecimal("100.00") } } }
  let(:invalid_params) { { :account => { :agency => "2222", :number => "11111"}, :credit => {:amount => "100.00"} } }

  let(:deposit) { create(:credit, :user_id => user.id, :amount => 10) }

  describe "GET 'show'" do

    before do
      get :show, :id => deposit.id
    end

    it "returns http success" do
      expect(response.status).to eq(200)
    end

    it "assigns @deposit" do
      expect(assigns(:deposit)).to eq(deposit)
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

    it "assigns @deposit" do
      expect(assigns(:deposit)).to be_a_new(Credit)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

  end

  describe "POST 'check'" do

    context "when account dont exist" do

      it "renders the new template" do
        post :check, invalid_params
        expect(response).to redirect_to(new_deposit_path)
      end

    end

    context "when account exists" do

      it "returns http success" do
        post :check, valid_params
        expect(response.status).to eq(200)
      end

      it "assigns @deposit" do
        post :check, valid_params
        expect(assigns(:deposit)).to be_a_new(Credit).with(valid_params[:credit])
      end

      it "renders the new template" do
        post :check, valid_params
        expect(response).to render_template("check")
      end

    end

  end

  describe "POST 'create'" do

    context "when params are valid" do

      it "create a new deposit" do
        expect{
          post :create, valid_params
        }.to change(Credit, :count).by(1)
      end

      it "redirects to the Deposit show" do
        post :create, valid_params
        expect(response).to redirect_to(deposit_path(Credit.last))
      end

      context "with amount of 0" do
        it "redirects to Deposits new" do
          valid_params[:credit][:amount] = BigDecimal(0)

          post :create, valid_params
          expect(response).to redirect_to(new_deposit_path)
        end
      end

    end

    context "with invalid params" do

      it "don't create a new deposit" do
        expect{
          post :create, invalid_params
        }.not_to change(Credit, :count).by(1)
      end

      it "redirects to new Deposit " do
        post :create, invalid_params
        expect(response).to redirect_to(new_deposit_path)
      end

    end

  end

end

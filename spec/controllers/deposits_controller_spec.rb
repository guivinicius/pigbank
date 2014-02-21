require 'spec_helper'

describe DepositsController do

  let(:user) { create(:user) }
  let(:valid_params) { { :agency_number => user.agency_number.to_s, :account_number => user.account_number.to_s, :credit => { :amount => BigDecimal("100.00") } } }
  let(:invalid_params) { { :agency_number => "2222", :account_number => "11111", :credit => {:amount => "100.00"} } }

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

    context "to a nonexistent account" do

      it "checks the account existence" do
        expect(User).to receive(:find_by).with(:agency_number => invalid_params[:agency_number], :account_number => invalid_params[:account_number])
        .and_return(nil)
        post :check, invalid_params
      end

      it "renders the new template" do
        post :check, invalid_params
        expect(response).to redirect_to(new_deposit_path)
      end

    end

    context "to a existent account" do

      it "returns http success" do
        post :check, valid_params
        expect(response.status).to eq(200)
      end

      it "checks the account existence" do
        expect(User).to receive(:find_by).with(:agency_number => valid_params[:agency_number], :account_number => valid_params[:account_number])
        .and_return(user)

        post :check, valid_params
      end

      it "assigns @deposit" do
        post :check, valid_params
        expect(assigns(:deposit)).to be_a_new(Transaction).with(valid_params[:credit])
      end

      it "renders the new template" do
        post :check, valid_params
        expect(response).to render_template("check")
      end

    end

  end

  describe "POST 'create'" do

    context "with valid_params" do

      it "checks the account existence" do
        expect(User).to receive(:find_by).with(:agency_number => valid_params[:agency_number], :account_number => valid_params[:account_number])
        .and_return(user)

        post :create, valid_params
      end

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

      it "checks the account existence" do
        expect(User).to receive(:find_by).with(:agency_number => invalid_params[:agency_number], :account_number => invalid_params[:account_number])
        .and_return(nil)

        post :create, invalid_params
      end

      it "create a new deposit" do
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

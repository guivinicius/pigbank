require 'spec_helper'

describe TransferencesController do

  login_user(:balance => 100)

  let(:user_2) { create(:user, :balance => 200) }

  let(:valid_params) do
    {
      :user => { :agency_number => user_2.agency_number, :account_number => user_2.account_number },
      :transference => { :amount =>  BigDecimal(50) }
    }
  end

  let(:invalid_params) do
    {
      :user => { :agency_number => "123", :account_number => "231232" },
      :transference => { :amount => "0" }
    }
  end

  let(:transference) { create(:transference, :from_user => @user, :to_user => user_2, :amount => 50) }

  describe "GET 'show'" do

    before do
      get :show, :id => transference.id
    end

    it "returns http success" do
      expect(response.status).to eq(200)
    end

    it "assigns @transference" do
      expect(assigns(:transference)).to eq(transference)
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

    it "assigns @transference" do
      expect(assigns(:transference)).to be_a_new(Transference)
    end

    it "renders new template" do
      expect(response).to render_template("new")
    end

  end

  describe "POST 'check'" do

    context "when params are valid" do

      before do
        post :check, valid_params
      end

      it "assigns @transference" do
        expect(assigns(:transference)).to be_a_new(Transference).with(valid_params[:transference])
      end

      it "renders check template" do
        expect(response).to render_template("check")
      end

    end

    context "when params are invalid" do

      it "redirects to Transference new" do
        post :check, invalid_params
        expect(response).to redirect_to(new_transference_path)
      end

    end

  end

  describe "POST 'create'" do

    context "when params are valid" do

      it "creates a new Transference" do
        expect{
          post :create, valid_params
        }.to change(Transference, :count).by(1)
      end

      it "redirects to Transference show" do
        post :create, valid_params
        expect(response).to redirect_to(transference_path(Transference.last))
      end

    end

    context "when params are invalid" do

      it "redirects to Transference new" do
        post :create, invalid_params
        expect(response).to redirect_to(new_transference_path)
      end

    end

  end

end

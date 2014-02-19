require 'spec_helper'

describe BalancesController do

  login_user

  describe "GET 'show'" do

    before { get :show }

    it "returns http success" do
      expect(response.status).to eq(200)
    end

    it "assigns @balance" do
      expect(assigns(:balance)).to eq(@user.balance)
    end

    it "renders show template" do
      expect(response).to render_template("show")
    end

  end

end

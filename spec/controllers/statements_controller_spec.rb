require 'spec_helper'

describe StatementsController do

  login_user

  describe "GET 'new'" do

    before do
      get :new
    end

    it "returns http success" do
      expect(response.status).to eql(200)
    end

    it "renders new template" do
      expect(response).to render_template(:new)
    end

  end

  describe "GET 'show'" do

    before do
      get :show, { :start_date => "", :end_date => ""}
    end

    it "returns http success" do
      expect(response.status).to eql(200)
    end

    it "renders show template" do
      expect(response).to render_template(:show)
    end
  end

end

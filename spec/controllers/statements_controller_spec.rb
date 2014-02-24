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
      create(:account, :user => @user)
    end

    context "with empty dates" do

      before do
        get :show, { :start_date => "", :end_date => "" }
      end

      it "returns http success" do
        expect(response.status).to eql(200)
      end

      it "renders show template" do
        expect(response).to render_template(:show)
      end

    end

    context "with valid date range" do

      before do
        get :show, { :start_date => (Date.current - 5.days).to_s, :end_date => Date.current.to_s }
      end

      it "returns http success" do
        expect(response.status).to eql(200)
      end

      it "renders show template" do
        expect(response).to render_template(:show)
      end

    end

    context "with invalid date range" do

      before do
        get :show, { :start_date => Date.current.to_s, :end_date => (Date.current - 5.days).to_s }
      end

      it "redirects to Statements new" do
        expect(response).to redirect_to(new_statement_path)
      end

    end

  end

end

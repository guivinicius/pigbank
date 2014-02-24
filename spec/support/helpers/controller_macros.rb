module ControllerMacros

  def login_user(args = {})
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = create(:user, args)
      sign_in @user
    end
  end

end
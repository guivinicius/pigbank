require "spec_helper"

feature "Sign in" do

  scenario "a existing user" do
    @user = create(:user)
    @account = create(:account, :user => @user)

    visit new_user_session_path

    fill_in :user_uid, :with => @user.uid
    fill_in :user_password, :with => @user.password

    click_button "Sign in"

    expect(page).to have_content "Signed in successfully"
  end

end
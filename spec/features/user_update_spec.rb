require "spec_helper"

feature "Edit" do

  scenario "a new account" do
    @user = create(:user)

    visit new_user_session_path

    fill_in :user_uid, :with => @user.uid
    fill_in :user_password, :with => @user.password

    click_button "Sign in"

    visit edit_user_registration_path

    fill_in :user_name, :with => "Lucas"
    fill_in :user_current_password, :with => @user.password

    click_button "Update"

    expect(page).to have_content "You updated your account successfully"
  end

end
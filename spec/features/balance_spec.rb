require "spec_helper"

feature "View Balance" do

  given(:user) { create(:user, :balance => 1000.00) }

  background do
    visit new_user_session_path

    fill_in :user_uid, :with => user.uid
    fill_in :user_password, :with => user.password

    click_button "Sign in"

    visit balance_path
  end

  scenario "user current balance" do
    expect(page).to have_content "$1,000.00"
  end

end
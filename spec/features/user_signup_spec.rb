require "spec_helper"

feature "Sign up" do

  scenario "a new account" do
    visit new_user_registration_path

    fill_in :user_name, :with => "Guilherme Vinicius Moreira"
    fill_in :user_uid, :with => "25751508254"
    fill_in :user_email, :with => "gui.vinicius@gmail.com"

    fill_in :user_agency_number, :with => "22221"
    fill_in :user_account_number, :with => "313234"

    fill_in :user_password, :with => "12345678"
    fill_in :user_password_confirmation, :with => "12345678"

    click_button "Sign up"

    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "a existing account" do

    user = create(:user)

    visit new_user_registration_path

    fill_in :user_name, :with => "Guilherme Vinicius Moreira"
    fill_in :user_uid, :with => "25751508254"
    fill_in :user_email, :with => "gui.vinicius@gmail.com"

    fill_in :user_agency_number, :with => "22221"
    fill_in :user_account_number, :with => "313234"

    fill_in :user_password, :with => "12345678"
    fill_in :user_password_confirmation, :with => "12345678"

    click_button "Sign up"

    expect(page).to have_content "Email has already been taken"
  end

end
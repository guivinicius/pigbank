require "spec_helper"

feature "Transference" do

  given(:user_1) { create(:user, :balance => 100.00) }
  given(:user_2) { create(:user, :balance => 100.00) }

  background do
    visit new_user_session_path

    fill_in :user_uid, :with => user_1.uid
    fill_in :user_password, :with => user_1.password

    click_button "Sign in"

    visit new_transference_path
  end

  scenario "to a different user" do

    fill_in :user_agency_number, :with => user_2.agency_number
    fill_in :user_account_number, :with => user_2.account_number
    fill_in :transference_amount, :with => "50.00"

    click_button "Continue"

    expect(page).to have_content user_2.name

    click_button "Transfer"

    expect(page).to have_content "Amount transfered successfully."
  end

  scenario "to yourself" do

    fill_in :user_agency_number, :with => user_1.agency_number
    fill_in :user_account_number, :with => user_1.account_number
    fill_in :transference_amount, :with => "50.00"

    click_button "Continue"

    expect(page).to have_content "You can't make a transference to you own account."
  end

end
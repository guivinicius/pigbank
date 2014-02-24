require "spec_helper"

feature "Deposit" do

  given(:user) { create(:user) }
  given(:amount) { 100.00 }
  background do
    visit new_deposit_path
  end

  scenario "to a existing user" do

    fill_in :user_agency_number, :with => user.agency_number
    fill_in :user_account_number, :with => user.account_number
    fill_in :credit_amount, :with => amount

    click_button "Continue"

    expect(page).to have_content user.name

    click_button "Make deposit"

    expect(page).to have_content amount
  end

  scenario "to a non existing user" do

    fill_in :user_agency_number, :with => "121212"
    fill_in :user_account_number, :with => "12222222"
    fill_in :credit_amount, :with => amount

    click_button "Continue"

    expect(page).to have_content "User account not found."
  end

end
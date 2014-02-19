require "spec_helper"

feature "Deposit" do

  given(:user) { create(:user) }

  scenario "to a existing user as as signed off one" do

    visit new_deposit_path

    fill_in :agency_number, :with => user.agency_number
    fill_in :account_number, :with => user.account_number
    fill_in :transaction_amount, :with => "100.00"

    click_button "Continue"

    expect(page).to have_content user.name

    click_button "Make deposit"

    expect(page).to have_content "Amount deposited successfully."
  end

end
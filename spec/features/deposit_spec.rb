require "spec_helper"

feature "Deposit" do

  given(:user) { create(:user) }
  given(:account) { user.account }

  given(:amount) { 100.00 }

  background do
    visit new_deposit_path
  end

  scenario "to a existing user" do

    fill_in :account_agency, :with => account.agency
    fill_in :account_number, :with => account.number
    fill_in :credit_amount, :with => amount

    click_button "Continue"

    expect(page).to have_content user.name

    click_button "Make deposit"

    expect(page).to have_content amount
  end

  scenario "to a non existing user" do

    fill_in :account_agency, :with => "121212"
    fill_in :account_number, :with => "12222222"
    fill_in :credit_amount, :with => amount

    click_button "Continue"

    expect(page).to have_content "User can't be blank"
  end

end
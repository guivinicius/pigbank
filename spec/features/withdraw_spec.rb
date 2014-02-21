require "spec_helper"

feature "Withdraw" do

  given(:user) { create(:user, :balance => 1000.00) }

  background do
    visit new_user_session_path

    fill_in :user_uid, :with => user.uid
    fill_in :user_password, :with => user.password

    click_button "Sign in"

    visit new_withdraw_path
  end

  scenario "less than your current balance" do

    fill_in :debit_amount, :with => "100.00"
    click_button "Continue"
    expect(page).to have_content "100.00"

    fill_in :password, :with => user.password
    click_button "Withdraw"
    expect(page).to have_content "Withdrawal completed successfully."
  end

  scenario "more than your current balance" do

    fill_in :debit_amount, :with => "1010.00"
    click_button "Continue"
    expect(page).to have_content "You can't withdraw more than your current balance."
  end

  scenario "with a wrong password" do
    fill_in :debit_amount, :with => "100.00"
    click_button "Continue"

    fill_in :password, :with => "I'm wrong!"
    click_button "Withdraw"
    expect(page).to have_content "Wrong password."
  end

end
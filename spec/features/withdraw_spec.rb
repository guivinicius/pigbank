require "spec_helper"

feature "Withdraw" do

  given(:user) { create(:user) }
  given(:account) { user.account }

  background do
    account.balance = 1000
    account.save

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
    expect(page).to have_content "Amount must be less than or equal to"
  end

  scenario "with a wrong password" do
    fill_in :debit_amount, :with => "100.00"
    click_button "Continue"

    fill_in :password, :with => "I'm wrong!"
    click_button "Withdraw"
    expect(page).to have_content "Password is wrong."
  end

end
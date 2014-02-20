require "spec_helper"

feature "View Statement" do

  given(:user) { create(:user, :balance => 50) }

  background do

    @ctransaction = create(:credit_transaction, :user_id => user.id, :amount => 100, :created_at => Time.zone.now - 10.days)
    @dtransaction = create(:debit_transaction,  :user_id => user.id, :amount => 50, :created_at => Time.zone.now)

    visit new_user_session_path

    fill_in :user_uid, :with => user.uid
    fill_in :user_password, :with => user.password

    click_button "Sign in"

    visit new_statement_path
  end

  scenario "with no date range" do
    click_button "View"

    expect(page).to have_content "100"
    expect(page).to have_content "50"

    expect(page).to have_content "50"
  end

  scenario "with a date range" do
    start_date = (Date.current - 5.days).to_s
    end_date = Date.current.to_s

    fill_in :start_date, :with => start_date
    fill_in :end_date, :with => end_date

    click_button "View"

    expect(page).to have_content @dtransaction.id

    expect(page).to have_content "$50.00"
  end

  scenario "with a missing start date" do
    start_date = ""
    end_date = Date.current.to_s

    fill_in :start_date, :with => start_date
    fill_in :end_date, :with => end_date

    click_button "View"

    expect(page).to have_content "Invalid date range."
  end

  scenario "with a missing end date" do
    start_date = (Date.current - 10.days).to_s
    end_date = ""

    fill_in :start_date, :with => start_date
    fill_in :end_date, :with => end_date

    click_button "View"

    expect(page).to have_content "Invalid date range."
  end

end
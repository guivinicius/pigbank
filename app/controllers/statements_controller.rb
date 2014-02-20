class StatementsController < ApplicationController
  before_filter :authenticate_user!

  def new

  end

  def show

    if valid_date_range? || blank_dates?
      @transactions = current_user.transactions.created_between(params[:start_date], params[:end_date]).order(:created_at)
    else
      redirect_to new_statement_path, :alert => "Invalid date range."
    end

  end

  private

  def valid_date_range?
    Date.parse(params[:end_date]) >= Date.parse(params[:start_date]) rescue false
  end

  def blank_dates?
    params[:end_date].blank? && params[:start_date].blank?
  end

end

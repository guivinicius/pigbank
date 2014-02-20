class StatementsController < ApplicationController
  before_filter :authenticate_user!

  def new

  end

  def show
    @transactions = current_user.transactions.where(:created_at => date_range).order(:created_at)
  end

  private

  def date_range
    if params[:start_date].empty? && params[:end_date].empty?
      (Time.zone.now - 30.days)..Time.zone.now
    else
      Time.zone.parse(params[:start_date])..Time.zone.parse("#{params[:end_date]} 23:59:59")
    end
  end

end

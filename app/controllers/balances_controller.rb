class BalancesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @balance = current_user.balance
  end

end

class WithdrawsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @withdraw = current_user.transactions.new(:activity_type => 1)
  end

  def check
    @withdraw = current_user.transactions.new(:activity_type => 1)

    if can_withdraw?
      @withdraw.amount = params[:transaction][:amount]
    else
      flash[:error] = "You can't withdraw more than your current balance."
      render :new
    end

  end

  def create
    @withdraw = current_user.transactions.new(:activity_type => 1)
    @withdraw.amount = params[:transaction][:amount]

    if can_withdraw? && correct_password?

      if @withdraw.save
        flash[:notice] = "Withdrawal completed successfully."
      else
        flash[:error] = "Sorry. Something happend during the transaction of your withdraw."
        render :new
      end

    else
      flash[:error] = "Wrong password."
      render :check
    end

  end

  private

  def can_withdraw?
    current_user.balance >= BigDecimal(params[:transaction][:amount])
  end

  def correct_password?
    current_user.valid_password?(params[:password])
  end

end

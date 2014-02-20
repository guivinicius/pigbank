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
      redirect_to new_withdraw_path, :alert => "You can't withdraw more than your current balance."
    end

  end

  def create
    @withdraw = current_user.transactions.new(:activity_type => 1)
    @withdraw.amount = params[:transaction][:amount]

    if can_withdraw? && correct_password?

      if @withdraw.save
        redirect_to withdraw_path(@withdraw), :notice => "Withdrawal completed successfully."
      else
        redirect_to new_withdraw_path, :alert => "Sorry. Something happend during the transaction of your withdraw."
      end

    else
      redirect_to new_withdraw_path, :alert => "Wrong password."
    end

  end

  def show
    @withdraw = current_user.transactions.find(params[:id])
  end

  private

  def can_withdraw?
    current_user.balance >= BigDecimal(params[:transaction][:amount])
  end

  def correct_password?
    current_user.valid_password?(params[:password])
  end

end

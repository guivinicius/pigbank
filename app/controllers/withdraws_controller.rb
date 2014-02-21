class WithdrawsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :new_withdraw, :except => [:show]

  def new
  end

  def check

    if can_withdraw?
      @withdraw.amount = params[:debit][:amount]
    else
      redirect_to new_withdraw_path, :alert => "You can't withdraw more than your current balance."
    end

  end

  def create
    @withdraw.amount = params[:debit][:amount]

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
    @withdraw = current_user.debits.find(params[:id])
  end

  private

  def new_withdraw
    @withdraw = current_user.debits.new
  end

  def can_withdraw?
    current_user.balance >= BigDecimal(params[:debit][:amount])
  end

  def correct_password?
    current_user.valid_password?(params[:password])
  end

end

class DepositsController < ApplicationController

  def new
    @deposit = Credit.new
  end

  def check

    @user = User.by_account(params[:account])
    @deposit = Credit.new(:user => @user, :amount => credit_params[:amount], :activity_type => 0)

    if @deposit.invalid?
      redirect_to new_deposit_path, :alert => @deposit.errors.full_messages
    end

  end

  def create
    user = User.by_account(params[:account])
    deposit = Credit.new(:user => user, :amount => credit_params[:amount], :activity_type => 0, :description => "Deposit")

    if CreditService.new(deposit).credit!
      redirect_to deposit_path(deposit), :notice => "Amount deposited successfully."
    else
      redirect_to new_deposit_path, :alert => deposit.errors.full_messages
    end

  end

  def show
    @receipt = ReceiptPresenter.new(Credit.find(params[:id]))
  end

  private

  def credit_params
    params.require(:credit).permit(:amount)
  end

end

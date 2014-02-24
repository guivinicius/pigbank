class DepositsController < ApplicationController

  def new
    @deposit = Credit.new
  end

  def check
    @user = User.by_account(params[:account])
    credit_service = CreditService.new(@user, credit_params[:amount])
    if credit_service.valid?
      @deposit = Credit.new(credit_params)
    else
      redirect_to new_deposit_path, :alert => credit_service.errors.full_messages
    end

  end

  def create
    user = User.by_account(params[:account])
    credit_service = CreditService.new(user, credit_params[:amount], "Deposit")
    if credit_service.valid?
      @deposit = credit_service.credit!
      redirect_to deposit_path(@deposit), :notice => "Amount deposited successfully."
    else
      redirect_to new_deposit_path, :alert => credit_service.errors.full_messages
    end

  end

  def show
    @deposit = Credit.find(params[:id])
    @user = @deposit.user
  end

  private

  def credit_params
    params.require(:credit).permit(:amount)
  end

end

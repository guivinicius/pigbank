class WithdrawsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @withdraw = Debit.new
  end

  def check
    @withdraw = Debit.new(:user => current_user, :amount => withdraw_params[:amount], :activity_type => 1)

    if @withdraw.invalid?
      redirect_to new_withdraw_path, :alert => @withdraw.errors.full_messages
    end

  end

  def create
    @withdraw = Debit.new(:user => current_user, :amount => withdraw_params[:amount], :activity_type => 1, :description => "Withdraw")

    if DebitService.new(@withdraw).debit_with_password!(params[:password])
      redirect_to withdraw_path(@withdraw), :notice => "Withdrawal completed successfully."
    else
      redirect_to new_withdraw_path, :alert => @withdraw.errors.full_messages
    end

  end

  def show
    @receipt = ReceiptPresenter.new(current_user.debits.find(params[:id]))
  end

  private

  def withdraw_params
    params.require(:debit).permit(:amount)
  end

end

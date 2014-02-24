class WithdrawsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @withdraw = Debit.new
  end

  def check
    debit_service = DebitService.new(current_user, withdraw_params[:amount])
    if debit_service.valid?
      @withdraw = Debit.new(withdraw_params)
    else
      redirect_to new_withdraw_path, :alert => debit_service.errors.full_messages
    end

  end

  def create
    debit_service = DebitService.new(current_user, withdraw_params[:amount], "Withdraw", params[:password])
    if debit_service.valid?
      @withdraw = debit_service.debit!
      redirect_to withdraw_path(@withdraw), :notice => "Withdrawal completed successfully."
    else
      redirect_to new_withdraw_path, :alert => debit_service.errors.full_messages
    end

  end

  def show
    @withdraw = Debit.find(params[:id])
  end

  private

  def withdraw_params
    params.require(:debit).permit(:amount)
  end

end

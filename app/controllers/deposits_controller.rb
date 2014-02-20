class DepositsController < ApplicationController

  def new
    @deposit = Transaction.new(:activity_type => 0)
  end

  def check

    if find_user_account
      @deposit = @user.transactions.new(transaction_params)
    else
      redirect_to new_deposit_path, :alert => "User account not found."
    end

  end

  def create

      if find_user_account
        @deposit = @user.transactions.new(transaction_params)
        if @deposit.save
          redirect_to deposit_path(@deposit), :notice => "Amount deposited successfully."
        else
          redirect_to new_deposit_path, :alert => "Sorry. Something happend during the transaction of your deposit."
        end
      else
        redirect_to new_deposit_path, :alert => "User account not found."
      end

  end

  def show
    @deposit = Transaction.find(params[:id])
    @user = @deposit.user
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :activity_type)
  end

  def find_user_account
    @user = User.find_by(:agency_number => params[:agency_number], :account_number => params[:account_number])
  end

end

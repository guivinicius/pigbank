class DepositsController < ApplicationController

  def new
    @deposit = Credit.new
  end

  def check

    if find_user_account
      @deposit = @user.credits.new(credit_params)
    else
      redirect_to new_deposit_path, :alert => "User account not found."
    end

  end

  def create

      if find_user_account
        @deposit = @user.credits.new(credit_params)
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
    @deposit = Credit.find(params[:id])
    @user = @deposit.user
  end

  private

  def credit_params
    params.require(:credit).permit(:amount)
  end

  def find_user_account
    @user = User.find_by(:agency_number => params[:agency_number], :account_number => params[:account_number])
  end

end

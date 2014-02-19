class DepositsController < ApplicationController
  def new
    @deposit = Transaction.new(:activity_type => 0)
  end

  def check

    @user = User.find_by(:agency_number => params[:agency_number], :account_number => params[:account_number])

    if @user
      @deposit = @user.transactions.new(transaction_params)
    else
      @deposit = Transaction.new(:activity_type => 0)
      flash[:error] = "User account not found."
      render :new
    end

  end

  def create

      @user = User.find_by(:agency_number => params[:agency_number], :account_number => params[:account_number])

      if @user
        @deposit = @user.transactions.new(transaction_params)
        if @deposit.save
          flash[:notice] = "Amount deposited successfully."
        else
          flash[:error] = "Sorry. Something happend during the transaction of your deposit."
          render :new
        end
      else
        @deposit = Transaction.new(:activity_type => 0)
        flash[:error] = "User account not found."
        render :new
      end

  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :activity_type)
  end

end

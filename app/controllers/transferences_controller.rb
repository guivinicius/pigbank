class TransferencesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @transference = Transference.new
  end

  def check

    @user = User.by_account(params[:account])
    @transference = Transference.new(:from_user => current_user, :to_user => @user, :amount => transference_params[:amount])

    if @transference.valid?
      @fee = FeeService.new(transference_params[:amount]).calculate
    else
      redirect_to new_transference_path, :alert => @transference.errors.full_messages
    end

  end

  def create

    user = User.by_account(params[:account])
    transference = Transference.new(:from_user => current_user, :to_user => user, :amount => transference_params[:amount])

    if TransferenceService.new(transference).transfer!
      redirect_to transference_path(transference), :notice => "Amount transfered successfully."
    else
      redirect_to new_transference_path, :alert => transference.errors.full_messages
    end

  end

  def show
    @receipt = ReceiptPresenter.new(current_user.transferences.find(params[:id]))
  end

  private

  def transference_params
    params.require(:transference).permit(:amount)
  end

end

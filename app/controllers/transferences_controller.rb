class TransferencesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @transference = Transference.new
  end

  def check

    @user = User.find_by(params[:user])
    transference_service = TransferenceService.new(current_user, @user, transference_params[:amount])
    if transference_service.valid?
      @transference = Transference.new(transference_params)
    else
      redirect_to new_transference_path, :alert => transference_service.errors.full_messages
    end

  end

  def create

    user = User.find_by(params[:user])
    transference_service = TransferenceService.new(current_user, user, transference_params[:amount])
    if transference_service.valid?
      transference = transference_service.transfer!
      redirect_to transference_path(transference), :notice => "Amount transfered successfully."
    else
      redirect_to new_transference_path, :alert => transference_service.errors.full_messages
    end

  end

  def show
    @transference = Transference.find(params[:id])
    @user = @transference.from_user
  end

  private

  def transference_params
    params.require(:transference).permit(:amount)
  end

end

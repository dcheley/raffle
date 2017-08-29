class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin, only: [:index]

  def index
    @users = User.all
  end

  def show
    current_user.admin? ? @user = current_user : @user = User.find(params[:id]) 
    @transaction = Transaction.new
    @transactions = @user.transactions
    @tickets = @user.tickets
    respond_to do |format|
      format.html
      format.csv { send_data @transactions.to_csv, filename: "#{@user.name}/OPS-Raffle/#{Date.today}.csv" }
    end
  end

  private

  def verify_admin
    (current_user.nil?) ? redirect_to(root_url) : (redirect_to(root_url, notice: 'Unauthorized')  unless current_user.admin?)
  end
end

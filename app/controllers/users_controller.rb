class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @transaction = Transaction.new
    @transactions = @user.transactions

    respond_to do |format|
      format.html
      format.csv { send_data @transactions.to_csv, filename: "#{@user.name}/OPS-Raffle/#{Date.today}.csv" }
    end
  end
end

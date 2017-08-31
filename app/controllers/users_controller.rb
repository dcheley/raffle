class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin, only: [:index]

  def intro
  end

  def index
    @users = User.all
  end

  def show
    !current_user.admin? ? @user = current_user : @user = User.find(params[:id])
    @transaction = Transaction.new
    @transactions = @user.transactions
    @tickets = @user.tickets
    respond_to do |format|
      format.html
      format.csv { send_data @transactions.to_csv, filename: "#{@user.name}/OPS-Raffle/#{Date.today}.csv" }
    end
  end

  def send_payment_confirmation
    @user = current_user
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      UserMailer.payment_confirmation(@transaction).deliver_later
      format.html { redirect_to user_url(@user), notice:'Ticket confirmation email sent' }
      format.json { render json: @user, status: :created, location: @user }
    end
  end

  # Plug this logic into new ticket deletion process later
  def send_delete_notice
    @user = current_user
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      UserMailer.delete_notice(@transaction).deliver_later
      format.html { redirect_to user_url(@user), notice:'Ticket deletion notice email sent' }
      format.json { render json: @user, status: :created, location: @user }
    end
  end

  private

  def verify_admin
    (current_user.nil?) ? redirect_to(user_url(current_user)) : (redirect_to(user_url(current_user), notice: 'Unauthorized')  unless current_user.admin?)
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin, only: [:index]
  before_action :load_user, only: [:show, :index, :trash, :send_payment_confirmation]

  def intro
  end

  def index
    @users = User.all
    @transactions = Transaction.where(payment_check: 1)
  end

  def show
    @transaction = Transaction.new
    @transactions = Transaction.where(user_id: current_user)
    @csv_transactions = Transaction.all
    @tickets = @user.tickets
    respond_to do |format|
      format.html
      format.csv { send_data @csv_transactions.to_csv, filename: "#{@user.name}/OPS-Raffle/#{Date.today}.csv" }
    end
  end

  def trash
    @transactions = Transaction.only_deleted.where(user_id: @user.id)
  end

  def bank_instructions
  end

  def send_payment_confirmation
    @transaction = Transaction.find(params[:id])
    respond_to do |format|
      @transaction.update_attributes(sent_confirmation: 1)
      UserMailer.payment_confirmation(@transaction).deliver_later
      format.html { redirect_to user_url(@user), notice:'Ticket confirmation email sent' }
      format.json { render json: @user, status: :created, location: @user }
    end
  end

  private
  def load_user
    !params[:id].nil? ? @user = User.find(params[:id]) : @user = current_user
  end

  def verify_admin
    (current_user.nil?) ? redirect_to(user_url(current_user)) : (redirect_to(user_url(current_user), notice: 'Unauthorized')  unless current_user.admin?)
  end
end

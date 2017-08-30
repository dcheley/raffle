class TransactionsController < ApplicationController
  before_action :load_transaction, only: [:edit, :update, :destroy]

  def create
    @transaction = Transaction.new(transaction_params)
    @user = @transaction.user
    @transactions = @user.transactions
    calculate_debt

    if @transaction.save
      @transaction.quantity.times { Ticket.create(number: rand(100000..999999), transaction_id: @transaction.id) }
    end

    respond_to do |format|
      if @transaction.save && @transaction.payment_check == 1
        UserMailer.payment_confirmation(@transaction).deliver_later
        format.html { redirect_to user_url(@user), notice:'Transaction added & ticket sent' }
        format.json { render json: @user, status: :created, location: @user }
      elsif @transaction.save && @transaction.payment_check != 1
        format.html { redirect_to user_url(@user), notice:'Transaction added' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render 'users/show' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = current_user
  end

  def update
    update_ticket_numbers
    respond_to do |format|
      if @transaction.update_attributes(transaction_params) && @transaction.payment_check == 1
        calculate_debt
        UserMailer.payment_confirmation(@transaction).deliver_later
        format.html { redirect_to user_url(current_user), notice: 'Transaction info updated & confirmation email sent to payee' }
        format.json { render json: current_user, status: :created, location: current_user }
      elsif @transaction.update_attributes(transaction_params) && @transaction.payment_check != 1
        calculate_debt
        format.html { redirect_to user_url(current_user), notice: 'Transaction info updated' }
        format.json { render json: current_user, status: :created, location: current_user }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.tickets.destroy_all
    @transaction.destroy
    redirect_to user_url(current_user), notice: 'Transaction deleted'
  end

  private

  def load_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:full_name, :email, :ministry, :price, :quantity,
    :payment_check, :user_id, :ticket_numbers, :deposit_check, :date_deposited)
  end

  def calculate_debt
    if @transaction.quantity != nil && @transaction.quantity % 2 != 0
      n = @transaction.quantity * 2.50
      @transaction.update_attributes(price: n + 0.5)
    elsif @transaction.quantity != nil && @transaction.quantity % 2 == 0
      n = @transaction.quantity * 2.50
      @transaction.update_attributes(price: n)
    end
  end

  def update_ticket_numbers
    if @transaction.update_attributes(transaction_params)
      if @transaction.tickets.count < @transaction.quantity
        i = @transaction.quantity - @transaction.tickets.count
        i.times { Ticket.create(number: rand(100000..999999), transaction_id: @transaction.id) }
      elsif @transaction.tickets.count > @transaction.quantity
        i = @transaction.tickets.count - @transaction.quantity
        i.times { @transaction.tickets.last.destroy }
      end
    end
  end
end

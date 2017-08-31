class TransactionsController < ApplicationController
  before_action :load_transaction, only: [:edit, :update, :destroy]

  def create
    @transaction = Transaction.new(transaction_params)
    @user = @transaction.user
    @transactions = @user.transactions
    calculate_price

    respond_to do |format|
      if @transaction.save
        @transaction.quantity.times { Ticket.create(number: rand(100000..999999), transaction_id: @transaction.id) }
        format.html { redirect_to user_url(@user), notice:'Transaction added & ticket #s generated' }
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
    respond_to do |format|
      if @transaction.update_attributes(transaction_params)
        update_ticket_numbers
        calculate_price
        format.html { redirect_to user_url(current_user), notice: 'Transaction info updated' }
        format.json { render json: current_user, status: :created, location: current_user }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
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

  def calculate_price
    if @transaction.quantity != nil && @transaction.quantity % 2 != 0
      n = @transaction.quantity * 2.50
      @transaction.update_attributes(price: n + 0.5)
    elsif @transaction.quantity != nil && @transaction.quantity % 2 == 0
      n = @transaction.quantity * 2.50
      @transaction.update_attributes(price: n)
    end
  end

  def update_ticket_numbers
    if @transaction.tickets.count < @transaction.quantity
      i = @transaction.quantity - @transaction.tickets.count
      i.times { Ticket.create(number: rand(100000..999999), transaction_id: @transaction.id) }
    elsif @transaction.tickets.count > @transaction.quantity
      i = @transaction.tickets.count - @transaction.quantity
      i.times { @transaction.tickets.last.destroy }
    end
  end
end

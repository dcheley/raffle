class TransactionsController < ApplicationController
  before_action :load_transaction, only: [:edit, :update, :destroy]

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.ticket_number = rand(100000..999999)
    @user = @transaction.user
    @transactions = @user.transactions
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to user_url(@user), notice:'Transaction Added' }
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
    if @transaction.update_attributes(transaction_params)
      redirect_to user_url(current_user), notice: 'Transaction info updated'
    else
      render :edit
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
    params.require(:transaction).permit(:payee, :email, :ministry, :debt,
    :quantity, :status, :user_id, :ticket_number)
  end
end

class TransactionsController < ApplicationController
  before_action :load_transaction, only: [:edit, :destroy]

  def create
    @transaction = Transaction.new(transaction_params)
    @user = @transaction.user
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to user_url(@user), notice:'Transaction Added' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render user_url(@user) }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @transaction.update_attributes(transaction_params)
      redirect_to '/transactions', notice: 'Transaction Info Updated'
    else
      render :edit
    end
  end

  def destroy
    @transaction.destroy
    redirect_to '/transactions', notice: 'Transaction Deleted'
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

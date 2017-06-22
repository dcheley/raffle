class TransactionsController < ApplicationController
  before_action :load_transaction, only: [:new, :edit, :destroy]

  def new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to '/transactions', notice: 'Transaction Added'
    else
      render :new
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
    :quantity, :status, :user_id)
  end
end

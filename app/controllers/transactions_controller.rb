class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
    render component: 'Transactions', props: { transactions: @transactions }
  end

  def create
    @transaction = Transaction.new(transaction_params)
    respond_to do |format|
      format.json do
        if @transaction.save
          render :json => @transaction
        else
          render :json => { :errors => @transaction.errors.messages }, :status => 422
        end
      end
    end
  end

  def update
    @transaction = Transaction.find(params[:id])
    respond_to do |format|
      format.json do
        if @transaction.update(transaction_params)
          render :json => @transaction
        else
          render :json => { :errors => @transaction.errors.messages }, :status => 422
        end
      end
    end
  end

  def destroy
    Transaction.find(params[:id]).destroy
    respond_to do |format|
      format.json { render :json => {}, :status => :no_content }
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:payee, :email, :ministry, :debt,
    :quantity, :status, :user_id)
  end
end

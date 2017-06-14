class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
    render component: 'Transactions', props: { transactions: @transactions }
  end
end

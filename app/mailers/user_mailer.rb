class UserMailer < ApplicationMailer
  def payment_confirmation(transaction)
    @transaction = transaction

    @url = 'http://ops-raffle.herokuapp.com'
    mail( to: @transaction.email, subject: 'OPS Walk & Run Ticket Confirmation')
  end

  def delete_notice(transaction)
    @transaction = transaction

    @url = 'http://ops-raffle.herokuapp.com'
    mail( to: @transaction.email, subject: 'OPS Walk & Run Ticket Deletion Notice')
  end
end

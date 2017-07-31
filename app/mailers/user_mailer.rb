class UserMailer < ApplicationMailer
  def payment_confirmation(transaction)
    @transaction = transaction

    @url = 'http://ops-raffle.herokuapp.com'
    mail( to: @transaction.email, subject: 'OPS Walk & Run Ticket Confirmation')
  end
end

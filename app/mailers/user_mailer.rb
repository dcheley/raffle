class UserMailer < ApplicationMailer
  def payment_confirmation(email)
    @transaction.payee = email

    @url = 'http://ops-raffle.herokuapp.com'
    mail (to: email, subject: 'OPS Walk & Run Ticket Confirmation')
  end
end

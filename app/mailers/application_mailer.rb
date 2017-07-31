class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.GMAIL_USERNAME
  layout 'mailer'
end

class ApplicationMailer < ActionMailer::Base
  default from: ENV['mail_account']
  layout 'mailer'
end
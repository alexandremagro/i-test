class ApplicationMailer < ActionMailer::Base
  default from: Const::CONTACT_EMAIL
  layout 'mailer'
end

class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:from_email)
  layout "mailer"
end

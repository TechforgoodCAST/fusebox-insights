# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'Fusebox <no-reply@fusebox.org.uk>'
  layout 'mailer'
end

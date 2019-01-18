# frozen_string_literal: true

class NotificationsMailer < ApplicationMailer
  def weekly_review(user)
    @user = user
    mail to: user.email, subject: 'Your Fusebox status update is due soon'
  end
end

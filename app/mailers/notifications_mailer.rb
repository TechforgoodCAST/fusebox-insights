# frozen_string_literal: true

class NotificationsMailer < ApplicationMailer
  def weekly_review(user)
    @user = user
    mail to: user.email, subject: 'Time for your weekly reflection'
  end
end

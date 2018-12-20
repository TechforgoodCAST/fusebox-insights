# frozen_string_literal: true

class NotificationsMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/notifications_mailer/weekly_review
  def weekly_review
    user = User.new(id: 1, email: 'to@example.com', username: 'username')
    NotificationsMailer.weekly_review(user)
  end
end

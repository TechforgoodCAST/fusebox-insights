# frozen_string_literal: true

class NotificationsMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/notifications_mailer/project_invite
  def project_invite
    membership = Membership.new(
      project: Project.new(id: 1),
      user: User.new(email: 'to@example.com')
    )
    NotificationsMailer.project_invite(membership)
  end
end

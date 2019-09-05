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

  def check_in_due
    NotificationsMailer.check_in_due(iteration)
  end

  def check_in_overdue
    NotificationsMailer.check_in_overdue(iteration)
  end

  private

  def iteration
    Iteration.new(id: 1, project: Project.new(id: 1))
  end
end

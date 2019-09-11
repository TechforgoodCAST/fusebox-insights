# frozen_string_literal: true

class NotificationsMailer < ApplicationMailer
  def project_invite(membership)
    @membership = membership
    mail to: @membership.user.email, subject: "You've been added to a project on Fusebox"
  end

  def check_in_due(iteration)
    @iteration = iteration
    emails = emails_by_role(iteration, %w[contributor mentor])
    mail to: emails, subject: 'Check-in due'
  end

  def check_in_complete(check_in, user)
    @check_in = check_in
    @iteration = @check_in.iteration
    @project = @check_in.iteration.project
    @user = user
	emails = emails_by_role(@iteration, %w[contributor mentor])
    mail to: emails, subject: "#{@user.full_name} has completed a check-in for #{@iteration.title}"
  end

  def check_in_overdue(iteration)
    @iteration = iteration
    emails = emails_by_role(iteration, %w[contributor mentor])
    mail to: emails, subject: 'Check-in overdue!'
  end

  private

  def emails_by_role(iteration, roles = [])
    Membership.joins(:user).where(project_id: iteration.project_id, role: roles).pluck(:email)
  end
end

# frozen_string_literal: true

class NotificationsMailer < ApplicationMailer
  def project_invite(membership, inviter)
    @membership = membership

    capabilities = {
      # You can...
      'contributor' => 'create and edit all items in the project. You will receive reminders about submitting check-ins and debriefs.',
      'stakeholder' => 'view the project but cannot modify it. You will receive a notification when the team submits a debrief.',
      'mentor' => 'create and edit all items in the project. You will receive reminders about submitting check-ins and debriefs.'
    }

    @capabilities = capabilities[@membership.role]
    @inviter = inviter
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

  def debrief_due(iteration)
    @iteration = iteration
    emails = emails_by_role(iteration, %w[contributor mentor])
    mail to: emails, subject: 'Debrief due'
  end

  def debrief_complete(debrief, user)
    @debrief = debrief
    @iteration = @debrief.iteration
    @project = @debrief.iteration.project
    @user = user
    emails = emails_by_role(@iteration, %w[contributor mentor stakeholder])
    mail to: emails, subject: "#{@user.full_name} has completed a debrief for #{@iteration.title}"
  end

  def debrief_overdue(iteration)
    @iteration = iteration
    emails = emails_by_role(@iteration, %w[contributor mentor])
    mail to: emails, subject: 'Debrief overdue!'
  end

  def support_requested(support_request, project)
    @request = support_request
    @project = project
    @beneficiary = @request.on_behalf_of || @request.requester
    @offer = support_request.offer
    @mentor = emails_by_role(@request, %w[mentor])
    mail to: @offer.provider_email, cc: @beneficiary.email, bcc: @mentor, reply_to: @beneficiary.email, subject: 'New support request'
  end

  private

  def emails_by_role(obj, roles = [])
    Membership.joins(:user).where(project_id: obj.project_id, role: roles).pluck(:email)
  end
end

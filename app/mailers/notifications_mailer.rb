# frozen_string_literal: true

class NotificationsMailer < ApplicationMailer
  def project_invite(membership)
    @membership = membership
    mail to: @membership.user.email, subject: "You've been added to a project on Fusebox"
  end
  
  def check_in_complete(check_in, user, recipient)
    @check_in = check_in
    @project = @check_in.iteration.project
    @user = user
    @recipient = recipient
    mail to: @recipient.email, subject: "#{@user.full_name} has completed a check-in for #{@project.title}"
  end
end

# frozen_string_literal: true

class NotificationsMailer < ApplicationMailer
  def project_invite(membership)
    @membership = membership
    mail to: @membership.user.email, subject: "You've been added to a project on Fusebox"
  end
end

# frozen_string_literal: true

module ProjectsHelper
  # TODO: review

  def get_membership(project, user = current_user)
    @member = Membership.where(project: project, user: user).first
  end

  def private_label(project)
    { true => 'Private', false => 'Public' }[project.is_private]
  end
end

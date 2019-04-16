# frozen_string_literal: true

module ProjectsHelper
  def get_membership(project)
    @member = ProjectMember.where(project: project, user: current_user).first
  end

  def private_label(project)
    { true => 'Private', false => 'Public' }[project.is_private]
  end
end

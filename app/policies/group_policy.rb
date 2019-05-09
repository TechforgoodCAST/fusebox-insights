# frozen_string_literal: true

class GroupPolicy < ApplicationPolicy
  def show?
    if record.project.is_private?
      ProjectMember.find_by(project: record.project, user: user)
    else
      true
    end
  end

  def create?
    ProjectMember.find_by(project: record.project, user: user, role: 'Admin')
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end

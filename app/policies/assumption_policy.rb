# frozen_string_literal: true

class AssumptionPolicy < ApplicationPolicy
  def index?
    project_member?(record, user)
  end

  def show?
    project_member?(record.project, user)
  end

  def create?
    ProjectMember.find_by(project: record.project, user: user, role: %w[Admin Collaborator])
  end

  def update?
    return false if record.new_record?

    user&.id == record.author_id ||
      ProjectMember.find_by(project: record.project, user: user, role: 'Admin')
  end

  def destroy?
    update?
  end

  def comment?
    ProjectMember.find_by(project: record.project, user: user)
  end

  def focus?
    show? if user
  end

  private

  def project_member?(project, user)
    if project.is_private?
      ProjectMember.find_by(project: project, user: user)
    else
      true
    end
  end
end

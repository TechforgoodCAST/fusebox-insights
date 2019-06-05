# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def show?
    if record.is_private?
      ProjectMember.find_by(project: record, user: user)
    else
      true
    end
  end

  def update?
    ProjectMember.find_by(project: record, user: user, role: 'Admin')
  end

  def destroy?
    update?
  end

  def knowledge_board?
    show?
  end
end

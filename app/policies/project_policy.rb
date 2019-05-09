# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def show?
    if record.is_private?
      ProjectMember.find_by(project: record, user: user)
    else
      true
    end
  end

  def edit?
    ProjectMember.find_by(project: record, user: user, role: 'Admin')
  end

  def knowledge_board?
    show?
  end

  def assumptions?
    show?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end

# frozen_string_literal: true

class AssumptionPolicy < ApplicationPolicy
  # TODO: refactor
  def show?
    if user
      if ProjectMember.where(project: record.project, user: user).any?
        true
      else
        user.id == record.project.author.id || !record.project.is_private
      end
    else
      !record.project.is_private?
    end
  end

  # TODO: refactor
  def new?
    if user
      if ProjectMember.where(project: record.project, user: user).any?
        true
      else
        user.id == record.project.author.id || !record.project.is_private
      end
    end
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
end

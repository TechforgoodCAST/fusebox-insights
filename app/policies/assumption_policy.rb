# frozen_string_literal: true

class AssumptionPolicy < ApplicationPolicy
  def index?
    membership?(record, user)
  end

  def show?
    membership?(record.project, user)
  end

  def create?
    Membership.find_by(project: record.project, user: user, role: %w[Admin Collaborator])
  end

  def update?
    return false if record.new_record?

    user&.id == record.author_id ||
      Membership.find_by(project: record.project, user: user, role: 'Admin')
  end

  def destroy?
    update?
  end

  def comment?
    Membership.find_by(project: record.project, user: user)
  end

  def focus?
    show? if user
  end

  private

  def membership?(project, user)
    if project.is_private?
      Membership.find_by(project: project, user: user)
    else
      true
    end
  end
end

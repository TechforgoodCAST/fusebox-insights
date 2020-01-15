# frozen_string_literal: true

class IterationPolicy < ApplicationPolicy
  def show?
    Membership.find_by(project: record.project, user: user) || user.is_admin?
  end

  def create?
    Membership.find_by(project: record.project, user: user, role: %w[contributor mentor]) || user.is_admin?
  end

  def update?
    create?
  end
  
  def destroy?
    (Membership.find_by(project: record.project, user: user, role: %w[contributor mentor]) && record.status_planned?)  || user.is_admin?
  end
end

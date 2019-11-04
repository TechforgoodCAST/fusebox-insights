# frozen_string_literal: true

class DebriefPolicy < ApplicationPolicy
  def show?
    Membership.find_by(project: record.iteration.project, user: user) || user.is_admin?
  end

  def create?
    Membership.find_by(project: record.iteration.project, user: user, role: %w[contributor mentor]) || user.is_admin?
  end

  def update?
    create?
  end
end

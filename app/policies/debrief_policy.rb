# frozen_string_literal: true

class DebriefPolicy < ApplicationPolicy
  def show?
    Membership.find_by(project: record.iteration.project, user: user)
  end

  def create?
    Membership.find_by(project: record.iteration.project, user: user, role: %w[contributor mentor])
  end

  def update?
    create?
  end
end

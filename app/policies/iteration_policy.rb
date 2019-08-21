# frozen_string_literal: true

class IterationPolicy < ApplicationPolicy
  def show?
    Membership.find_by(project: record.project, user: user)
  end

  def create?
    Membership.find_by(project: record.project, user: user, role: %w[contributor mentor])
  end

  def update?
    create?
  end
end

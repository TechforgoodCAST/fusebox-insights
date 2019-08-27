# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def show?
    Membership.find_by(project: record, user: user)
  end

  def create?
    true
  end

  def update?
    Membership.find_by(project: record, user: user, role: %w[contributor mentor])
  end

  def about?
    show?
  end
end

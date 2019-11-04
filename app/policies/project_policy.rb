# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def show?
    Membership.find_by(project: record, user: user) || user.is_admin?
  end

  def create?
    true
  end

  def update?
    Membership.find_by(project: record, user: user, role: %w[contributor mentor]) || user.is_admin?
  end

  def about?
    show?
  end
end

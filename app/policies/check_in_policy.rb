# frozen_string_literal: true

class CheckInPolicy < ApplicationPolicy
  def show?
    Membership.find_by(project: record.iteration.project, user: user, role: %w[contributor mentor]) || user.is_admin?
  end

  def create?
    show?
  end

  def update?
    show?
  end
end

# frozen_string_literal: true

class IterationPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
    @project = record.project
  end

  def show?
    is_project_member?
  end

  def create?
    is_project_member?(%w[contributor mentor])
  end

  def update?
    create?
  end

  def destroy?
    (is_project_member?(%w[contributor mentor]) && record.status_planned?) || is_admin?
  end
end

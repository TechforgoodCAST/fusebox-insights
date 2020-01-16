# frozen_string_literal: true

class DebriefPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
    @project = record.iteration.project
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
end

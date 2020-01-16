# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
    @project = record
  end

  def show?
    is_project_member?
  end

  def create?
    true
  end

  def update?
    is_project_member?(%w[contributor mentor])
  end

  def about?
    show?
  end
end

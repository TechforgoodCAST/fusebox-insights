# frozen_string_literal: true

class CheckInPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
    @project = record.iteration.project
  end
  
  def show?
    is_project_member?(%w[contributor mentor])
  end

  def create?
    show?
  end

  def update?
    show?
  end
end

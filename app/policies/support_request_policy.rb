# frozen_string_literal: true

class SupportRequestPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
    @project = record.project
  end

  def create?
    is_project_member?(%w[contributor mentor])
  end
end

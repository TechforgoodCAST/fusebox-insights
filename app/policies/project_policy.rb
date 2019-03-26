# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def show?
    if user
      user.id == record.user.id || !record.is_private
    else
      !record.is_private
    end
  end

  def edit?
    user.id == record.user.id
  end

  def update?
    user.id == record.user.id
  end

  def destroy?
    user.id == record.user.id
  end
end

# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def show?
    if user
      if ProjectMember.where(project: record, user: user).any?
        true
      else
        user.id == record.user.id || !record.is_private
      end
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

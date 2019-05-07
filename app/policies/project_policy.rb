# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def show?
    if user
      if ProjectMember.where(project: record, user: user).any?
        true
      else
        user.id == record.author.id || !record.is_private
      end
    else
      !record.is_private
    end
  end

  def edit?
    if ProjectMember.where(project: record, user: user, role: "Admin").any?
      true
    elsif record.is_private
      user.id == record.author.id
    end
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end

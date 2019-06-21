# frozen_string_literal: true

class MembershipPolicy < ApplicationPolicy
  def new?
    if Membership.where(project: record.project, user: user, role: 'Admin').any?
      true
    elsif Membership.where(project: record.project, user: user, role: 'Collaborator').any?
      true
    else
      user.id == record.project.author.id
    end
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def destroy?
    new?
  end
end

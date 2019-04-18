# frozen_string_literal: true

class ProjectMemberPolicy < ApplicationPolicy
  def new?
    if ProjectMember.where(project: record.project, user: user, role: "Admin").any?
      true
    elsif ProjectMember.where(project: record.project, user: user, role: "Collaborator").any?
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

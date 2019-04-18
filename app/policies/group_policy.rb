class GroupPolicy < ApplicationPolicy
  def create?
    if ProjectMember.where(project: record.project, user: user, role: "Admin").any?
      true
    else
      user.id == record.project.author.id
    end
  end

  def edit?
    if ProjectMember.where(project: record.project, user: user, role: "Admin").any?
      true
    else
      user.id == record.project.author.id
    end
  end


  def update?
    edit?
  end

  def destroy?
    edit?
  end
end

class GroupPolicy < ApplicationPolicy
  def create?
    if ProjectMember.where(project: record.project, user: user, role: "Admin").any?
      true
    else
      user.id == record.project.user.id
    end
  end

  def edit?
    if ProjectMember.where(project: record.project, user: user, role: "Admin").any?
      true
    else
      user.id == record.project.user.id
    end
  end


  def update?
    if ProjectMember.where(project: record.project, user: user, role: "Admin").any?
      true
    else
      user.id == record.project.user.id
    end

  end

  def destroy?
    if ProjectMember.where(project: record.project, user: user, role: "Admin").any?
      true
    else
      user.id == record.project.user.id
    end
  end
end

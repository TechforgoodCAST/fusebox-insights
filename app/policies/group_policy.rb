class GroupPolicy < ApplicationPolicy

  def show?
    if user
      if ProjectMember.where(project: record.project, user: user).any?
        true
      else
        user.id == record.project.author.id || !record.project.is_private
      end
    else
      !record.project.is_private?
    end
  end

  def create?

    if !user
      false
    else
      if ProjectMember.where(project: record.project, user: user, role: "Admin").any?
        true
      else
        user.id == record.project.author.id
      end
    end

  end

  def edit?

    if !user
      false
    else
      if ProjectMember.where(project: record.project, user: user, role: "Admin").any?
        true
      else
        user.id == record.project.author.id
      end
    end

  end


  def update?
    edit?
  end

  def destroy?
    edit?
  end
end

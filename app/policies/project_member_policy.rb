class ProjectMemberPolicy < ApplicationPolicy

  def new?
    user.id == record.project.user.id
  end

  def create?
    user.id == record.project.user.id
  end

  def destroy?
    user.id == record.project.user.id
  end

end
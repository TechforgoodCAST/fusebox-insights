class ProjectMemberPolicy < ApplicationPolicy

  def destroy?
    user.id == record.project.user.id
  end

end
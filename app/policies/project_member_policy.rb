class ProjectMemberPolicy < ApplicationPolicy

  def new?
    TODO: implement
  end

  def create?
    TODO: implement
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
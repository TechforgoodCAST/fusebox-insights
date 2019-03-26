class SupportMessagePolicy < ApplicationPolicy

  def new?
    user.id === record.project.user.id
  end

  def edit?
    user.id == record.project.user.id
  end

  def update?
    user.id == record.project.user.id
  end

  def destroy?
    user.id == record.project.user.id
  end

end
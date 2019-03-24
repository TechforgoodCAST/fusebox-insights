class SupportMessagePolicy < ApplicationPolicy

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
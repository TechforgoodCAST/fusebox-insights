class ProjectPolicy < ApplicationPolicy
  
  def show?
    if user
      user.id == record.user.id || !record.private
    else
      !record.private
    end
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
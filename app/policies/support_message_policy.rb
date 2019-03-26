class SupportMessagePolicy < ApplicationPolicy

  def new?
    user.is_staff
  end

  def edit?
    user.is_staff
  end

  def update?
    user.is_staff
  end

  def destroy?
    user.is_staff
  end

end
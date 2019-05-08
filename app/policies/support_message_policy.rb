# frozen_string_literal: true

class SupportMessagePolicy < ApplicationPolicy
  def index?
    user&.is_staff
  end

  def create?
    user&.is_staff
  end

  def update?
    user&.is_staff
  end

  def destroy?
    user&.is_staff
  end
end

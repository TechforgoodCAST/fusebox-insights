# frozen_string_literal: true

class MembershipPolicy < ApplicationPolicy
  def show?
    {
      'contributor' => true,
      'mentor' => true,
      'stakeholder' => false
    }[record&.role]
  end

  def create?
    show?
  end

  def destroy?
    show?
  end
end

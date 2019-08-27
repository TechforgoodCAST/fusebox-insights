# frozen_string_literal: true

require 'test_helper'

class MembershipPolicyTest < ActiveSupport::TestCase
  setup do
    @membership = build(:membership)
    @subject = MembershipPolicy.new(@membership.user, @membership)
  end

  test 'users can access index' do
    assert(@subject.index?)
  end

  test 'contributor can view, create and destroy memberships' do
    assert_authorised(%i[show? new? create? destroy?])
  end

  test 'mentor can view, create and destroy memberships' do
    @membership.role = 'mentor'
    assert_authorised(%i[show? new? create? destroy?])
  end

  test 'stakeholder cannot view, create and destroy memberships' do
    @membership.role = 'stakeholder'
    assert_authorised(%i[show? new? create? destroy?], permitted: false)
  end
end

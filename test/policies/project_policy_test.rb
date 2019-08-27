# frozen_string_literal: true

require 'test_helper'

class ProjectPolicyTest < ActiveSupport::TestCase
  setup do
    @membership = create(:membership)
    @subject = ProjectPolicy.new(@membership.user, @membership.project)
  end

  test 'users can create projects' do
    assert_authorised(%i[new? create?])
  end

  test 'contributor can view and update projects' do
    assert_authorised(%i[show? edit? update? about?])
  end

  test 'mentor can view and update projects' do
    @membership.role = 'mentor'
    assert_authorised(%i[show? edit? update? about?])
  end

  test 'stakeholder can view projects' do
    @membership.role = 'stakeholder'
    assert_authorised(%i[show? about?])
  end

  test 'stakeholder cannot update projects' do
    @membership.update(role: 'stakeholder')
    assert_authorised(%i[edit? update?], permitted: false)
  end
end

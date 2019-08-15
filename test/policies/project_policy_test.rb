# frozen_string_literal: true

require 'test_helper'

class ProjectPolicyTest < ActiveSupport::TestCase
  setup do
    @membership = create(:membership)
    @subject = ProjectPolicy.new(@membership.user, @membership.project)
  end

  test '#create? true' do
    assert(@subject.create?)
  end

  test 'contributor can view and edit projects' do
    assert_authorised(%i[show? edit? about?])
  end

  test 'mentor can view and edit projects' do
    @membership.role = 'mentor'
    assert_authorised(%i[show? edit? about?])
  end

  test 'stakeholder can view projects' do
    @membership.role = 'stakeholder'
    assert_authorised(%i[show? about?])
  end

  test 'stakeholder cannot edit projects' do
    @membership.update(role: 'stakeholder')
    assert_authorised(%i[edit?], permitted: false)
  end
end

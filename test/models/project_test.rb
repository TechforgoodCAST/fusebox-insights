# frozen_string_literal: true

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  setup do
    @subject = build(:project)
  end

  test 'belongs to #user' do
    assert_kind_of(User, @subject.user)
  end

  test 'user has many projects' do
    @user = create(:user)
    @a = create(:project, user: @user, name: 'a')
    @ab = create(:project, user: @user, name: 'b')
    assert_equal(2, @user.created_projects.size)
  end

  test 'slug generation' do
    @project_name = 'this is a test'
    @new_project = build(:project, name: @project_name)
    assert_equal(@new_project.valid?, true)
    assert_equal(@project_name.parameterize, @new_project.slug)
  end

  test '#name unique to user' do
    assert_unique(:name)
  end

  test '#is_private cannot be nil' do
    @invalid_project = Project.new(name: 'invalid test', is_private: nil)
    assert_equal(@invalid_project.valid?, false)
  end

  test '#slug is unique' do
    assert_unique(:slug)
  end

  test '#is_private has default' do
    @project = Project.new(name: 'default is_private')
    assert_equal(@project.is_private, true)
  end
end

# frozen_string_literal: true

require 'test_helper'

# TODO: update tests
class ProjectTest < ActiveSupport::TestCase
  setup do
    @subject = build(:project)
  end

  test 'belongs to #author' do
    assert_kind_of(User, @subject.author)
  end

  test('has many #assumptions') { assert_has_many(:assumptions) }

  test('destroys #assumptions') { assert_destroys(:assumptions) }

  test('has many #groups') { assert_has_many(:groups) }

  test('destroys #groups') { assert_destroys(:groups) }

  test('has many #insights') { assert_has_many(:insights) }

  test('destroys #insights') { assert_destroys(:insights) }

  test('has many #support_messages') { assert_has_many(:support_messages) }

  test('destroys #support_messages') { assert_destroys(:support_messages) }

  test 'user has many projects' do
    @user = create(:user, projects: build_list(:project, 2))
    assert_equal(2, @user.projects.size)
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

  test '#is_private has default' do
    @project = Project.new(name: 'default is_private')
    assert_equal(@project.is_private, true)
  end
end

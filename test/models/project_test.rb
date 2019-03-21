require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup 
    @user = build(:user)
    @subject = Project.create(name: 'test', slug: 'this-should-be-unique', user: @user)
    @subject.save
  end

  test 'belongs to #user' do
    assert_kind_of(User, @subject.user)
  end

  test 'user has many projects' do
    @new_project = Project.create(name: 'test', user: @user, slug: '123')
    @another_new_project = Project.create(name: 'test', user: @user, slug: '456')
    assert_equal(3, @user.projects.size)
  end

  test 'slugs must be unique' do
    @project_1 = Project.create(name: 'test', user: @user, slug: 'test-slug')
    @project_2 = Project.create(name: 'test', user: @user, slug: 'test-slug')
    assert_equal(@project_2.valid?, false)
  end

end

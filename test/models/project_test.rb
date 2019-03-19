require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup 
    @subject = build(:project)
    @user = build(:user)
    @subject.user = @user
    @subject.save
  end

  test 'belongs to #user' do
    assert_kind_of(User, @subject.user)
  end

  test 'user has many projects' do
    create_list(:project, 2, user: @user)
    assert_equal(3, @user.projects.size)
  end

end

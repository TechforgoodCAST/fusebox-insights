require 'test_helper'

class ProjectMemberTest < ActiveSupport::TestCase

  setup do
    @test_user = build(:user)
    @test_project = build(:project)
  end

  test 'user can have many memberships' do
    create_list(:project_member, 2, user: @test_user)
    assert_equal(@test_user.projects.size, 2)
  end

  test 'projects can have many members' do
    create_list(:project_member, 2, project: @test_project)
    assert_equal(@test_project.users.size, 2)
  end

end

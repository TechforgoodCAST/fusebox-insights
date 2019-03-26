# frozen_string_literal: true

require 'test_helper'

class ProjectMemberTest < ActiveSupport::TestCase
  test 'user can have many memberships' do
    user = build(:user)
    create_list(:project_member, 2, user: user)
    assert_equal(user.projects.size, 2)
  end

  test 'projects can have many members' do
    project = build(:project)
    create_list(:project_member, 2, project: project)
    assert_equal(project.users.size, 2)
  end
end

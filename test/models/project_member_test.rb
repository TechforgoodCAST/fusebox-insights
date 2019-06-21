# frozen_string_literal: true

require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  test 'user can have many memberships' do
    user = build(:user)
    create_list(:membership, 2, user: user)
    assert_equal(user.projects.size, 2)
  end

  test 'projects can have many members' do
    project = build(:project)
    create_list(:membership, 2, project: project)
    assert_equal(project.users.size, 2)
  end
end

# frozen_string_literal: true

require 'application_system_test_case'

class MembershipsTest < ApplicationSystemTestCase
  test 'contributor can view, create and destroy memberships'
  test 'mentor can view, create and destroy memberships'
  test 'stakeholder cannot view, create and destroy memberships'
  test 'user are notified when added to a project'
end

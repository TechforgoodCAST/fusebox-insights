# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  test 'can create project and assigned as contributor'
  test 'contributor can view and update projects'
  test 'mentor can view and update projects'
  test 'stakeholder can view projects'
  test 'stakeholder cannot update projects'
end

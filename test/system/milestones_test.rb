# frozen_string_literal: true

require 'application_system_test_case'

class MilestonesTest < ApplicationSystemTestCase
  test 'update milestone statues'
  test 'contributor can view, create and update milestones'
  test 'mentor can view, create and update milestones'
  test 'stakeholder can view milestones'
  test 'stakeholder cannot create or update milestones'
end

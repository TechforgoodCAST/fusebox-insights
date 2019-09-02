# frozen_string_literal: true

require 'application_system_test_case'

class CheckInsTest < ApplicationSystemTestCase
  setup do
    @check_in = build(:check_in)
    @iteration = build(:iteration, check_ins: [@check_in])
    @project = build(:project, iterations: [@iteration])
    @user = create(:user, projects: [@project])
    visit new_user_session_path
  end
  
  test 'stakeholder cannot create check ins' do
    Membership.last.update(role: :stakeholder)
    visit new_project_iteration_check_in_path(@project, @iteration)
    assert_text("Sorry, you don't have access to that")
  end
  
  test 'stakeholder cannot view check ins' do
    Membership.last.update(role: :stakeholder)
    visit project_iteration_check_in_path(:project_id => @project.id, :iteration_id => @iteration.id, :id => @check_in.id)
    assert_text("Sorry, you don't have access to that")
  end
end

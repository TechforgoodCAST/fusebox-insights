# frozen_string_literal: true

require 'application_system_test_case'

class CheckInsTest < ApplicationSystemTestCase
  setup do
    @check_in = create(:check_in)
    @iteration = @check_in.iteration
    @project = @check_in.iteration.project
    @user = create(:user, projects: [@project])
    visit new_user_session_path
    sign_in
  end

  test 'stakeholder cannot create check ins' do
    Membership.last.update(role: :stakeholder)
    visit new_project_iteration_check_in_path(@project, @iteration)

    assert_text("Sorry, you don't have access to that")
  end

  test 'stakeholder cannot view check ins' do
    Membership.last.update(role: :stakeholder)
    visit project_iteration_check_in_path(@project, @iteration, @check_in)

    assert_text("Sorry, you don't have access to that")
  end

  test 'check ins are listed on iteration' do
    create(:check_in, iteration: @iteration)
    visit project_iteration_path(@project, @iteration)

    assert_link('Check in', count: 2)
  end

  test 'check ins hidden to stakeholders' do
    Membership.last.update(role: :stakeholder)
    visit project_iteration_path(@project, @iteration)

    assert_no_link('Check in')
  end
end

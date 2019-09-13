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

  test 'check-ins are listed on iteration' do
    create(:check_in, iteration: @iteration)
    visit project_iteration_path(@project, @iteration)

    assert_link('Check in', count: 2)
  end

  test 'check-ins hidden to stakeholders' do
    Membership.last.update(role: :stakeholder)
    visit project_iteration_path(@project, @iteration)

    assert_no_link('Check in')
  end

  test 'contributors can create check-ins' do
    Membership.last.update(role: :contributor)
    visit new_project_iteration_check_in_path(@project, @iteration)
    assert_text('New check-in')
  end

  test 'contributors can view check-ins' do
    Membership.last.update(role: :contributor)
    visit project_iteration_check_in_path(@project, @iteration, @check_in)
    assert_text('Check-In')
  end

  test 'mentors can create check-ins' do
    Membership.last.update(role: :mentor)
    visit new_project_iteration_check_in_path(@project, @iteration)
    assert_text('New check-in')
  end

  test 'mentors can view check-ins' do
    Membership.last.update(role: :mentor)
    visit project_iteration_check_in_path(@project, @iteration, @check_in)
    assert_text('Check-In')
  end

  test 'mentors and contributors are notified when a check-in is completed' do
    Membership.last.update(role: :contributor)
    @contributor = @user
    @mentor = create(:user, projects: [@project])
    Membership.last.update(role: :mentor)

    visit new_project_iteration_check_in_path(@project, @iteration)
    click_on 'Submit check-in'

    mail = ActionMailer::Base.deliveries.last

    recipients = [
      @contributor.email,
      @mentor.email
    ]
    
  	assert_equal("#{@user.full_name} has completed a check-in for #{@iteration.title}", mail.subject)

    mail.to.each do |recipient|
      assert_includes(recipients, recipient)
    end
  end

  test 'stakeholder cannot create check-ins' do
    Membership.last.update(role: :stakeholder)
    visit new_project_iteration_check_in_path(@project, @iteration)

    assert_text("Sorry, you don't have access to that")
  end

  test 'stakeholder cannot view check-ins' do
    Membership.last.update(role: :stakeholder)
    visit project_iteration_check_in_path(@project, @iteration, @check_in)

    assert_text("Sorry, you don't have access to that")
  end
end

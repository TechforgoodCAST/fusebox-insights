# frozen_string_literal: true

require 'application_system_test_case'

class CheckInsTest < ApplicationSystemTestCase
  setup do
    @iteration = create(:committed_iteration)
    @project = @iteration.project
    @user = create(:user, projects: [@project])
    visit new_user_session_path
    sign_in
  end

  test 'check-ins are listed on iteration' do
    create(:check_in, iteration: @iteration)
    visit project_iteration_path(@project, @iteration)

    assert_link('Check-in')
  end

  test 'check-ins hidden to stakeholders' do
    Membership.last.update(role: :stakeholder)
    create(:check_in, iteration: @iteration)
    visit project_iteration_path(@project, @iteration)

    assert_no_link('Check-in')
  end

  test 'contributors can create check-ins' do
    Membership.last.update(role: :contributor)
    visit new_project_iteration_check_in_path(@project, @iteration)
    complete_check_in

    assert_check_in_created
  end

  test 'contributors can view check-ins' do
    Membership.last.update(role: :contributor)
    check_in = create(:check_in, iteration: @iteration)
    visit project_iteration_check_in_path(@project, @iteration, check_in)

    assert_text('Check-in')
  end

  test 'mentors can create check-ins' do
    Membership.last.update(role: :mentor)
    visit new_project_iteration_check_in_path(@project, @iteration)
    complete_check_in

    assert_check_in_created
  end

  test 'mentors can view check-ins' do
    Membership.last.update(role: :mentor)
    check_in = create(:check_in, iteration: @iteration)
    visit project_iteration_check_in_path(@project, @iteration, check_in)

    assert_text('Check-in')
  end

  test 'mentors and contributors are notified when a check-in is completed' do
    mentor = create(:user, projects: [@project])
    Membership.find_by(project: @project, user: mentor).update(role: :mentor)
    recipients = [@user.email, mentor.email]

    visit new_project_iteration_check_in_path(@project, @iteration)
    complete_check_in

    mail = ActionMailer::Base.deliveries.last

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
    check_in = create(:check_in, iteration: @iteration)
    visit project_iteration_check_in_path(@project, @iteration, check_in)

    assert_text("Sorry, you don't have access to that")
  end

  private

  def assert_check_in_created(iteration = @iteration)
    assert_link('Check-in')
    assert_text('ON TRACK')
    iteration.reload
    assert_not_nil(@iteration.last_check_in_at)
  end

  def complete_check_in(iteration = @iteration)
    iteration.outcomes.size.times do |i|
      choose("check_in_check_in_ratings_attributes_#{i}_score_0")
      fill_in("check_in_check_in_ratings_attributes_#{i}_comments", with: 'Comments')
    end
    click_on 'Submit check-in'
  end
end

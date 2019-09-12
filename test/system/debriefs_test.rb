# frozen_string_literal: true

require 'application_system_test_case'

class DebriefsTest < ApplicationSystemTestCase
  setup do
    @debrief = create(:debrief)
    @iteration = @debrief.iteration
    @project = @debrief.iteration.project
    @user = create(:user, projects: [@project])
    visit new_user_session_path
    sign_in
  end

  test 'debriefs are listed on iteration' do
    create(:debrief, iteration: @iteration)
    visit project_iteration_path(@project, @iteration)

    assert_link('Debrief', count: 2)
  end

  test 'contributors can create debriefs' do
    Membership.last.update(role: :contributor)
    visit new_project_iteration_debrief_path(@project, @iteration)
    assert_text('New debrief')
  end

  test 'contributors can view debriefs' do
    Membership.last.update(role: :contributor)
    visit project_iteration_debrief_path(@project, @iteration, @debrief)
    assert_text('Debrief')
  end

  test 'mentors can create debriefs' do
    Membership.last.update(role: :mentor)
    visit new_project_iteration_debrief_path(@project, @iteration)
    assert_text('New debrief')
  end

  test 'mentors can view debriefs' do
    Membership.last.update(role: :mentor)
    visit project_iteration_debrief_path(@project, @iteration, @debrief)
    assert_text('Debrief')
  end
  
  test 'stakeholder cannot create debriefs' do
    Membership.last.update(role: :stakeholder)
    visit new_project_iteration_debrief_path(@project, @iteration)

    assert_text("Sorry, you don't have access to that")
  end

  test 'stakeholder can view debriefs' do
    Membership.last.update(role: :stakeholder)
    visit project_iteration_debrief_path(@project, @iteration, @debrief)
    assert_text('Debrief')
  end

  test 'mentors and contributors are notified when a debrief is completed' do
    Membership.last.update(role: :contributor)
    @contributor = @user
    @mentor = create(:user, projects: [@project])
    Membership.last.update(role: :mentor)
    @stakeholder = create(:user, projects: [@project])
    Membership.last.update(role: :stakeholder)

    visit new_project_iteration_debrief_path(@project, @iteration)
    click_on 'Submit debrief'

    mail = ActionMailer::Base.deliveries.last

    recipients = [
      @contributor.email,
      @mentor.email,
      @stakeholder.email
    ]
    
  	assert_equal("#{@user.full_name} has completed a debrief for #{@iteration.title}", mail.subject)

    mail.to.each do |recipient|
      assert_includes(recipients, recipient)
    end
  end
  
  test 'iteration status changed to completed when debrief completed' do
    visit new_project_iteration_debrief_path(@project, @iteration)
    click_on 'Submit debrief'
    updated_iteration = Iteration.find(@iteration.id)
    assert_equal('completed', updated_iteration.status)
  end
  
end

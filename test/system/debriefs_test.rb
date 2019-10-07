# frozen_string_literal: true

require 'application_system_test_case'

class DebriefsTest < ApplicationSystemTestCase
  setup do
    @debrief = build(:debrief)
    @iteration = @debrief.iteration
    @project = @debrief.iteration.project
    @milestone = build(:milestone, status: 'committed')
    @project.milestones = [@milestone];
    @project.save!
    
    @user = create(:user, projects: [@project])
    visit new_user_session_path
    sign_in
  end

  test 'contributors can create debriefs' do
    Membership.last.update(role: :contributor)
    visit new_project_iteration_debrief_path(@project, @iteration)
    assert_text('New debrief')
  end

  test 'contributors can view debriefs' do
    @debrief.save!
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
    @debrief.save!
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
    @debrief.save!
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

    submit_debrief

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
    submit_debrief    
    updated_iteration = Iteration.find(@iteration.id)
    assert_equal('completed', updated_iteration.status)
  end
  
  test 'can complete milestone when submitting debrief' do
    visit new_project_iteration_debrief_path(@project, @iteration)
    choose 'Yes'
    click_on 'Submit debrief'
    
    updated_milestone = Milestone.find(@milestone.id)
    assert_equal('completed', updated_milestone.status)
  end
  
  test "don't have to complete milestone when submitting debrief" do
    visit new_project_iteration_debrief_path(@project, @iteration)
    choose 'No'
    click_on 'Submit debrief'
    
    updated_milestone = Milestone.find(@milestone.id)
    assert_equal('committed', updated_milestone.status)
  end
  
  test 'contributors and mentors can complete one debrief per iteration' do
    @debrief.save!
    visit new_project_iteration_debrief_path(@project, @iteration)
    
    assert_text("You've already debriefed this iteration")
  end
  
  private
  
  def submit_debrief
    visit new_project_iteration_debrief_path(@project, @iteration)
    choose 'No'
    click_on 'Submit debrief'
  end
  
end

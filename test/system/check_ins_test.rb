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
  
  test 'stakeholders cannot create check-ins' do
    Membership.last.update(role: :stakeholder)
    visit new_project_iteration_check_in_path(@project, @iteration)
    assert_text("Sorry, you don't have access to that")
  end
  
  test 'stakeholders cannot view check-ins' do
    Membership.last.update(role: :stakeholder)
    visit project_iteration_check_in_path(:project_id => @project.id, :iteration_id => @iteration.id, :id => @check_in.id)
    assert_text("Sorry, you don't have access to that")
  end
  
  test 'contributors can create check-ins' do
    Membership.last.update(role: :contributor)
    visit new_project_iteration_check_in_path(@project, @iteration)
    assert_text("New check-in")
  end
  
  test 'contributors can view check-ins' do
    Membership.last.update(role: :contributor)
    visit project_iteration_check_in_path(:project_id => @project.id, :iteration_id => @iteration.id, :id => @check_in.id)
    assert_text("Check-In")
  end
  
  test 'mentors can create check-ins' do
    Membership.last.update(role: :mentor)
    visit new_project_iteration_check_in_path(@project, @iteration)
    assert_text("New check-in")
  end
  
  test 'mentors can view check-ins' do
    Membership.last.update(role: :mentor)
    visit project_iteration_check_in_path(:project_id => @project.id, :iteration_id => @iteration.id, :id => @check_in.id)
    assert_text("Check-In")
  end
  
  test 'mentors and contributors are notified when a check-in is completed' do
    @mentor = create(:user, projects: [@project])
    Membership.last.update(role: :mentor)
    
    visit new_project_iteration_check_in_path(@project, @iteration)
    click_on 'Submit check-in'
    
    mails = ActionMailer::Base.deliveries.last(2)
    assert_equal(mails.size, 2)
    
    recipients = [
      @user.email,
      @mentor.email
    ]
    
    mails.each{ |mail|
      assert_includes(recipients, @mentor.email, mail.to[0])
      assert_equal("#{@user.full_name} has completed a check-in for #{@project.title}", mail.subject)
    }

  end
end

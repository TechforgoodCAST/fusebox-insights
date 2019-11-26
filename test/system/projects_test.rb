# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  include ApplicationHelper
  
  setup do
    @user = create(:user)
    visit projects_path
    sign_in
  end

  test 'sign in required' do
    project = build(:project, id: 1)
    click_on 'Sign out'

    [
      projects_path,
      project_path(project),
      edit_project_path(project)
    ].each do |path|
      visit path

      assert_text('You need to sign in or sign up before continuing.')
    end
  end

  test 'can view and create projects as contributor' do
    create_project

    assert_equal(project_path(Project.last), current_path)
    assert_equal('contributor', Membership.last.role)
  end

  test 'contributor can update projects' do
    create_project
    update_project

    assert_equal('Updated title', Project.last.title)
  end

  test 'mentor can view projects' do
    create_project
    Membership.last.update(role: :mentor)
    click_on('Roadmap')

    assert_equal(project_path(Project.last), current_path)
  end

  test 'mentor can update projects' do
    create_project
    Membership.last.update(role: :mentor)
    update_project

    assert_equal('Updated title', Project.last.title)
  end

  test 'stakeholder can view projects' do
    create_project
    Membership.last.update(role: :stakeholder)
    click_on('Roadmap')

    assert_equal(project_path(Project.last), current_path)
  end

  test 'stakeholder cannot update projects' do
    create_project
    Membership.last.update(role: :stakeholder)
    click_on('About')
    click_on('Edit')

    assert_text("Sorry, you don't have access to that")
  end
  
  test 'iteration card displays when there are no updates' do
    create_project
    @project = Project.last
    iteration = create(:committed_iteration, project: @project)
    visit project_path(@project)
    assert_text('No updates')
  end
  
  test 'iteration card displays latest check-in' do
    create_project
    @project = Project.last
    iteration = create(:committed_iteration, project: @project)
    @check_in = create(:check_in, iteration: iteration)
    visit project_path(@project)
    assert_text('Checked in on '+friendly_date(@check_in.created_at))
  end
  
  test 'iteration card displays check-in overdue' do
    create_project
    @project = Project.last    
    iteration = build(:committed_iteration, :check_in_overdue, project: @project)
    iteration.save! validate: false
    visit project_path(@project)
    assert_text('Over two weeks since last check in')
  end
  
  test 'iteration card displays debrief complete' do
    create_project
    @project = Project.last    
    @debrief = build(:debrief)
    iteration = build(:iteration, project: @project, debrief: @debrief, status: 'completed')
    iteration.save! validate: false
    visit project_path(@project)
    find('a', text: 'Completed').click
    assert_text('Debrief completed on '+friendly_date(iteration.debrief.created_at))
  end
  
  test 'iteration card displays debrief overdue' do
    create_project
    @project = Project.last    
    iteration = build(:committed_iteration, :debrief_overdue, project: @project)
    iteration.save! validate: false
    visit project_path(@project)
    assert_text('Debrief overdue')
  end

  test 'users can see their projects' do
    create_project
    Membership.last.update(role: :stakeholder)
    visit projects_path
    
    create_project
    Membership.last.update(role: :contributor)
    visit projects_path
    
    create_project
    Membership.last.update(role: :mentor)
    visit projects_path
    
    create(:project)
    
    assert_text('Stakeholder')
    assert_text('Contributor')
    assert_text('Mentor')
    assert_no_text('All Other Projects')
  end
  
  test 'admins can see all projects' do
    create(:project)
    User.last.update(is_admin: :true)
    visit projects_path
    
    assert_text('All Other Projects')
  end

  private

  def create_project(title: 'Title', description: 'Description')
    click_on('New project')
    fill_in(:project_title, with: title)
    fill_in(:project_description, with: description)
    click_on('Create Project')
  end

  def update_project
    click_on('About')
    click_on('Edit')
    fill_in(:project_title, with: 'Updated title')
    click_on('Update Project')
  end
end

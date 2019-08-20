# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    visit projects_path
    sign_in
  end

  test 'not signed in?'

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

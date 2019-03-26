# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @creator = create(:user)
    @public_project = create(:project, user: @creator, is_private: false)
    @private_project = create(:project, user: @creator, is_private: true)

    @new_project = build(:project, user: @creator)

    @non_creator = create(:user)

    visit projects_path
    sign_in(@creator)
  end

  test 'show index page' do
    assert_selector 'h1', text: 'My Projects'
  end

  test 'create project' do
    click_link 'Create New Project'
    fill_in 'project[name]', with: @new_project.name
    fill_in 'project[description]', with: @new_project.description
    click_on 'Create Project'
    assert_text 'Project created successfully.'
  end

  test 'update project' do
    first('.edit-link').click
    fill_in 'project[name]', with: @new_project.name
    fill_in 'project[description]', with: @new_project.description
    click_on 'Update Project'
    assert_text 'Project updated successfully.'
  end

  test 'destroy project' do
    first('.destroy-link').click
    page.driver.browser.switch_to.alert.accept
    assert_text 'Project destroyed successfully.'
  end

  test 'anon user cannot view private project' do
    sign_out
    visit project_path(@private_project)
    assert_text 'You need to sign in or sign up before continuing.'
  end

  test 'anon user can view public project' do
    visit project_path(@public_project)
    assert_text 'Project Name'
  end

  test 'non-creator cannot access edit project' do
    sign_out
    visit projects_path
    sign_in(@non_creator)
    visit edit_project_path(@public_project)
    assert_text "Sorry, you don't have access to that"
  end

  test 'non-creator cannot view private project' do
    sign_out
    visit projects_path
    sign_in(@non_creator)
    visit project_path(@private_project)
    assert_text "Sorry, you don't have access to that"
  end
end

# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @creator = create(:user)
    @public_project = create(:project, user: @creator, is_private: false)
    @private_project = create(:project, user: @creator, is_private: true)

    @new_project = build(:project, user: @creator)

    @non_creator = create(:user)

    @admin = create(:user)
    @admin_member = create(:project_member, user: @admin, project: @private_project)

    @collaborator = create(:user)
    @collaborator_member = create(:project_member, user: @collaborator, project: @private_project, role: "Collaborator")

    @viewer = create(:user)
    @admin_member = create(:project_member, user: @admin, project: @private_project, role: "Viewer")

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
    assert_text "Sorry, you don't have access to that"
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

  test 'collaborators and viewers cannot edit or delete the project' do
    sign_out
    visit projects_path
    sign_in(@collaborator)
    assert_no_text 'Edit'
    assert_no_text 'Destroy'

    visit edit_project_path(@private_project)
    assert_text "Sorry, you don't have access to that"

    sign_out
    visit projects_path
    sign_in(@viewer)
    assert_no_text 'Edit'
    assert_no_text 'Destroy'

    visit edit_project_path(@private_project)
    assert_text "Sorry, you don't have access to that"
  end

  test 'admin can update a private project' do
    sign_out
    visit projects_path
    sign_in(@admin)
    visit edit_project_path(@private_project)
    fill_in 'project[name]', with: @new_project.name
    fill_in 'project[description]', with: @new_project.description
    click_on 'Update Project'
    assert_text 'Project updated successfully.'
  end

  test 'admin can delete a private project' do
    sign_out
    visit projects_path
    sign_in(@admin)
    first('.destroy-link').click
    page.driver.browser.switch_to.alert.accept
    assert_text 'Project destroyed successfully.'
  end
end

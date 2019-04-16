# frozen_string_literal: true

require 'application_system_test_case'

class ProjectMembersTest < ApplicationSystemTestCase
  setup do
    @creator = create(:user)
    @non_creator = create(:user)
    @member = create(:user)

    @project = create(:project, user: @creator)
    @existing_member = create(:project_member, project: @project, user: @member)

    @admin = create(:user)
    @admin_member = create(:project_member, user: @admin, project: @project)

    @collaborator = create(:user)
    @collaborator_member = create(:project_member, user: @collaborator, project: @project, role: "Collaborator")

    @viewer = create(:user)
    @admin_member = create(:project_member, user: @admin, project: @project, role: "Viewer")

    visit projects_path
    sign_in(@creator)
  end

  test 'create member' do
    click_link 'Add Member'
    click_on 'Create Project member'
    assert_text 'Member added successfully.'
  end

  test 'destroy member' do
    first('.remove-member-link').click
    page.driver.browser.switch_to.alert.accept
    assert_text 'Member removed successfully.'
  end

  test 'non-owner access denied for create' do
    sign_out
    visit projects_path
    sign_in(@non_creator)
    visit new_project_member_path(@project)
    assert_text "Sorry, you don't have access to that"
  end

  test 'anon-user access denied for create' do
    sign_out
    visit new_project_member_path(@project)
    assert_text 'You need to sign in or sign up before continuing.'
  end

  test 'admins can add project members' do
    sign_out
    visit projects_path
    sign_in(@admin)
    visit new_project_member_path(@project)
    click_on 'Create Project member'
    assert_text 'Member added successfully.'
  end


  test 'admins can remove project members' do
    sign_out
    visit projects_path
    sign_in(@admin)
    first('.remove-member-link').click
    page.driver.browser.switch_to.alert.accept
    assert_text 'Member removed successfully.'
  end

  test 'collaborators can add project members' do
    sign_out
    visit projects_path
    sign_in(@collaborator)
    visit new_project_member_path(@project)
    click_on 'Create Project member'
    assert_text 'Member added successfully.'
  end


  test 'collaborators can remove project members' do
    sign_out
    visit projects_path
    sign_in(@collaborator)
    first('.remove-member-link').click
    page.driver.browser.switch_to.alert.accept
    assert_text 'Member removed successfully.'
  end

  test 'viewers cannot add project members' do
    sign_out
    visit projects_path
    sign_in(@viewer)
    visit new_project_member_path(@project)
    assert_text "Sorry, you don't have access to that"
  end
end

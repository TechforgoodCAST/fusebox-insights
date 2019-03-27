# frozen_string_literal: true

require 'application_system_test_case'

class ProjectMembersTest < ApplicationSystemTestCase
  setup do
    @creator = create(:user)
    @non_creator = create(:user)
    @member = create(:user)

    @project = create(:project, user: @creator)
    @existing_member = create(:project_member, project: @project, user: @member)

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
end

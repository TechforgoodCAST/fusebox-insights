# frozen_string_literal: true

require 'application_system_test_case'

class GroupsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @project = create(:project, author: @user, users: [@user])
    @group = @project.groups.first

    visit projects_path
    sign_in
  end

  test 'project admin can create group' do
    click_on @project.name
    click_on 'New Group'
    fill_in 'Title', with: @group.title + '1'
    fill_in 'Description', with: @group.description
    fill_in 'Summary', with: @group.summary
    click_on 'Save group'

    assert_text 'Group was successfully created'
  end

  test 'project admin can update group' do
    click_on @project.name
    click_on @group.title
    within('.card-footer') { click_on 'Edit' }
    fill_in 'Title', with: @group.title
    click_on 'Save group'

    assert_text 'Group was successfully updated'
  end

  test 'project admin can destroy group' do
    click_on @project.name
    click_on @group.title
    within('.card-footer') do
      page.accept_confirm { click_on 'Delete' }
    end

    assert_text 'Group has been deleted'
  end

  test 'project member cannot create group' do
    admin_to_collaborator
    visit project_path(@project)
    assert_no_link 'New Group'

    visit new_project_group_path(@project)
    assert_text "Sorry, you don't have access to that"
  end

  test 'project member cannot edit group' do
    admin_to_collaborator
    visit project_group_path(@project, @group)
    assert_no_link 'Edit'

    visit edit_project_path(@project, @group)
    assert_text "Sorry, you don't have access to that"
  end

  test 'project member cannot destroy group' do
    admin_to_collaborator
    visit project_group_path(@project, @group)
    assert_no_link 'Delete'
  end

  private

  def admin_to_collaborator
    @user.project_members.find_by(project: @project).update!(role: 'Collaborator')
  end
end

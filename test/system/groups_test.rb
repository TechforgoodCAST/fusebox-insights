# frozen_string_literal: true

require 'application_system_test_case'

class GroupsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @project = create(:project, author: @user)
    @group = create(:group, author: @user, project: @project)
    @new_group = build(:group, author: @user)

    @other_user = create(:user)
    @others_project = create(:project, author: @other_user)
    @others_group = create(:group, author: @other_user, project: @others_project)

    visit projects_url
    sign_in
  end

  test 'creating a Group' do
    visit project_path(@project)
    click_on 'New Group'

    fill_in 'Title', with: @new_group.title
    fill_in 'Description', with: @new_group.description
    fill_in 'Summary', with: @new_group.summary

    click_on 'Save group'

    assert_text 'Group was successfully created'
  end

  test 'updating a Group' do
    visit project_path(@project)
    click_on @group.title
    click_on 'Edit'

    fill_in 'Title', with: @new_group.title
    fill_in 'Description', with: @new_group.description
    fill_in 'Summary', with: @new_group.summary
    click_on 'Save group'

    assert_text 'Group was successfully updated'
  end

  test 'destroying a Group' do
    @group.update!(unknowns: create_list(:unknown, 2))
    visit project_group_path(@project, @group)
    click_on @group.title

    page.accept_confirm do
      click_on 'Delete', match: :first
    end

    assert_text 'Group was successfully destroyed'
  end

  test 'cant add a group when not an admin' do
    visit project_path(@others_project)
    click_on 'New Group'

    assert_text "Sorry, you don't have access to that"
  end

  test 'cant edit or remove a group when not an admin' do
    visit project_path(@others_project)
    click_on @others_group.title

    assert_no_text 'Edit'
    assert_no_text 'Delete'
  end

  test 'cant edit a group when not an admin through url' do
    visit edit_project_path(@others_project, @others_group)
    assert_text "Sorry, you don't have access to that"
  end
end

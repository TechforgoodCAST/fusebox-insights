# frozen_string_literal: true

require 'application_system_test_case'

class GroupsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @project = create(:project, user: @user)
    @group = create(:group, author: @user, project: @project)
    @new_group = build(:group, author: @user)

    visit projects_url
    sign_in
  end

  test 'creating a Group' do
    click_on 'Show'
    click_on 'New Group'

    fill_in 'Title', with: @new_group.title
    fill_in 'Description', with: @new_group.description
    find('trix-editor').click.set('A reason')

    click_on 'Create Group'

    assert_text 'Group was successfully created'
  end

  test 'updating a Group' do
    visit project_group_path(@project, @group)
    click_on @group.title
    click_on 'Edit'

    fill_in 'Title', with: @new_group.title
    fill_in 'Description', with: @new_group.description
    find('trix-editor').click.set('A reason')
    click_on 'Update Group'

    assert_text 'Group was successfully updated'
  end

  test 'destroying a Group' do
    visit project_group_path(@project, @group)
    click_on @group.title

    page.accept_confirm do
      click_on 'Delete', match: :first
    end

    assert_text 'Group was successfully destroyed'
  end
end

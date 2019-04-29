# frozen_string_literal: true

require 'application_system_test_case'

class UnknownsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @project = create(:project, name: 'test', author: @user)
    @unknown = create(:unknown, author: @user, project: @project)
    @new_unknown = build(:unknown, author: @user, project: @project)

    @other_user = create(:user)
    @others_unknown = create(:unknown, author: @other_user)

    @project = create(:project, author: @user)
    @group = create(:group, author: @user, project: @project)

    visit project_unknowns_url(@project)
    sign_in
  end

  test 'visiting the index' do
    assert_selector 'li', text: 'Assumptions'
  end

  test 'creating a Unknown' do
    click_on 'Add Assumption'

    fill_in 'Title', with: @new_unknown.title
    click_on 'Save assumption'

    assert_text 'Unknown was successfully created'
  end

  test 'updating a Unknown' do
    click_on @unknown.title
    click_on 'Edit'

    fill_in 'Title', with: @new_unknown.title
    click_on 'Save assumption'

    assert_text 'Unknown was successfully updated'
  end

  test 'nagivate pagination for more than 10 unknowns' do
    @unknowns_list = create_list(:unknown, 11, author: @user)
    visit project_unknowns_url(@project)

    assert_text 'Next'
    click_on 'Next'

    assert_text 'Prev'
    click_on 'Prev'

    assert_text 'Next'
  end

  test 'limit page to 10 records' do
    @unknowns_list = create_list(:unknown, 11, author: @user)
    visit project_unknowns_url(@project)

    assert_selector('div.card', maximum: 10)

    click_on '2'
    assert_selector('div.card', maximum: 10)
  end

  test 'destroying a Unknown' do
    click_on @unknown.title

    page.accept_confirm do
      click_on 'Delete', match: :first
    end

    assert_text 'Unknown was successfully destroyed'
  end

  test 'cant edit or delete a different users unknown' do
    click_on @others_unknown.title

    assert_no_text 'Edit'
    assert_no_text 'Delete'
  end

  test 'can edit and delete your own unknown' do
    click_on @unknown.title

    assert_text 'Edit'
    assert_text 'Delete'
  end

  test 'cannot visit unknown path if not author' do
    visit edit_project_unknown_path(@project, @others_unknown)
    assert_equal('/', current_path)
  end

  test 'can visit unknown path if author' do
    visit edit_project_unknown_path(@project, @unknown)
    assert_equal(edit_project_unknown_path(@project, @unknown), current_path)
  end

  test 'can  add an unknown to a group' do
    visit edit_project_unknown_path(@project, @unknown)
    select @group.title
    click_on 'Save assumption'

    assert_text 'Unknown was successfully updated'

    visit project_group_path(@project, @group)

    assert_text @group.title
  end

  test 'can remove an unknown from a group' do
    visit edit_project_unknown_path(@project, @unknown)
    select @group.title
    click_on 'Save assumption'

    visit project_group_path(@project, @group)

    page.accept_confirm do
      click_on 'Remove', match: :first
    end

    assert_text 'Assumption was successfully removed.'
  end
end

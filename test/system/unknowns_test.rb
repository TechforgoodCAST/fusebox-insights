# frozen_string_literal: true

require 'application_system_test_case'

class AssumptionsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @project = create(:project, name: 'test', author: @user)
    @assumption = create(:unknown, author: @user, project: @project)
    @new_unknown = build(:unknown, author: @user, project: @project)

    @other_user = create(:user)
    @others_unknown = create(:unknown, author: @other_user)

    @project = create(:project, author: @user)
    @group = create(:group, author: @user, project: @project)

    visit project_unknowns_path(@project)
    sign_in
  end

  test 'visiting the index' do
    assert_selector 'li', text: 'Assumptions'
  end

  test 'creating a Assumption' do
    click_on 'Add Assumption'

    fill_in 'Title', with: @new_unknown.title
    click_on 'Save assumption'

    assert_text 'Assumption was successfully created'
  end

  test 'updating a Assumption' do
    click_on @assumption.title
    click_on 'Edit'

    fill_in 'Title', with: @new_unknown.title
    click_on 'Save assumption'

    assert_text 'Assumption was successfully updated'
  end

  test 'nagivate pagination for more than 10 unknowns' do
    @assumptions_list = create_list(:unknown, 11, author: @user)
    visit project_unknowns_url(@project)

    assert_text 'Next'
    click_on 'Next'

    assert_text 'Prev'
    click_on 'Prev'

    assert_text 'Next'
  end

  test 'limit page to 10 records' do
    @assumptions_list = create_list(:unknown, 11, author: @user)
    visit project_unknowns_url(@project)

    assert_selector('div.card', maximum: 10)

    click_on '2'
    assert_selector('div.card', maximum: 10)
  end

  test 'destroying a Assumption' do
    click_on @assumption.title

    page.accept_confirm do
      click_on 'Delete', match: :first
    end

    assert_text 'Assumption was successfully destroyed'
  end

  test 'cant edit or delete a different users unknown' do
    click_on @others_unknown.title

    assert_no_text 'Edit'
    assert_no_text 'Delete'
  end

  test 'can edit and delete your own unknown' do
    click_on @assumption.title

    assert_text 'Edit'
    assert_text 'Delete'
  end

  test 'cannot visit unknown path if not author' do
    visit edit_project_assumption_path(@project, @others_unknown)
    assert_equal('/', current_path)
  end

  test 'can visit unknown path if author' do
    visit edit_project_assumption_path(@project, @assumption)
    assert_equal(edit_project_assumption_path(@project, @assumption), current_path)
  end

  test 'can  add an unknown to a group' do
    visit edit_project_assumption_path(@project, @assumption)
    select @group.title
    click_on 'Save assumption'

    assert_text 'Assumption was successfully updated'

    visit project_group_path(@project, @group)

    assert_text @group.title
  end

  test 'can remove an unknown from a group' do
    visit edit_project_assumption_path(@project, @assumption)
    select @group.title
    click_on 'Save assumption'

    visit project_group_path(@project, @group)

    page.accept_confirm do
      click_on 'Remove', match: :first
    end

    assert_text 'Assumption was successfully removed.'
  end
end

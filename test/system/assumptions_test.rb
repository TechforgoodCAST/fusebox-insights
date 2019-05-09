# frozen_string_literal: true

require 'application_system_test_case'

class AssumptionsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @project = create(:project, author: @user, users: [@user])
    @assumption = create(:assumption, author: @user, project: @project)

    visit new_user_session_path
    sign_in
    click_on @project.name
  end

  test 'visiting the index' do
    visit project_assumptions_path(@project)
    assert_selector 'li', text: 'Assumptions'
  end

  test 'anyone can view assumption in public project' do
    sign_out
    path = project_assumption_path(@project, @assumption)
    visit path
    assert_equal path, current_path
  end

  test 'member can view assumption in private project' do
    @project.update!(is_private: true)
    path = project_assumption_path(@project, @assumption)
    visit path
    assert_equal path, current_path
  end

  test 'non-member cannot view assumption in private project' do
    # TODO: prevent author access
    @project.update!(is_private: true, users: [])
    visit project_assumption_path(@project, @assumption)
    assert_text "Sorry, you don't have access to that"
    # TODO: assert 404 page
  end

  test 'creating a Assumption' do
    click_on 'Add Assumption'

    fill_in 'Title', with: @assumption.title + '1'
    click_on 'Save assumption'

    assert_text 'Assumption was successfully created'
  end

  test 'can update authored assumption' do
    visit project_assumption_path(@project, @assumption)
    within('.card-body') { click_on 'Edit' }
    fill_in 'Title', with: @assumption.title
    click_on 'Save assumption'
    assert_text 'Assumption was successfully updated'
  end

  test 'can delete authored assumption' do
    visit project_assumption_path(@project, @assumption)
    page.accept_confirm { click_on 'Delete' }
    assert_text 'Assumption archived'
  end

  test 'cannot update unauthored assumption' do
    @assumption.update!(author: create(:user))
    visit project_assumption_path(@project, @assumption)
    within('.card-body') { assert_no_text 'Edit' }

    visit edit_project_assumption_path(@project, @assumption)
    assert_text "Sorry, you don't have access to that"
  end

  test 'cannot delete unauthored assumption' do
    @assumption.update!(author: create(:user))
    visit project_assumption_path(@project, @assumption)
    assert_no_text 'Delete'
  end

  test 'can add an assumption to a group' do
    group = @project.groups.first
    visit edit_project_assumption_path(@project, @assumption)
    select group.title.humanize
    click_on 'Save assumption'

    assert_text 'Assumption was successfully updated'

    visit project_group_path(@project, group)

    assert_text group.title
  end

  test 'can remove an assumption from a group' do
    group = @project.groups.first
    visit edit_project_assumption_path(@project, @assumption)
    select group.title.humanize
    click_on 'Save assumption'

    visit project_group_path(@project, group)

    page.accept_confirm do
      click_on 'Remove', match: :first
    end

    assert_text 'Assumption was successfully removed.'
  end
end

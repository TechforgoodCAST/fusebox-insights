# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @project = create(:project, author: @user, users: [@user])

    visit projects_path
    sign_in
  end

  test 'user can view list of projects' do
    assert_selector 'h1', text: 'My Projects'
    assert_link @project.name
  end

  test 'visitor can view public project' do
    sign_out
    [
      project_path(@project),
      project_assumptions_path(@project),
      project_knowledge_board_path(@project)
    ].each do |path|
      visit path
      assert_equal(path, current_path)
    end
  end

  test 'visitor cannot view private project' do
    @project.update!(is_private: true, users: [])
    sign_out

    [
      project_path(@project),
      project_assumptions_path(@project),
      project_knowledge_board_path(@project)
    ].each do |path|
      visit path
      assert_not_equal(path, current_path)
    end
  end

  test 'user can create project' do
    click_link 'New project'
    fill_in 'Name', with: @project.name + 'create'
    click_on 'Save'
    assert_text 'Project created successfully'
  end

  test 'project admin can update project' do
    click_on @project.name
    click_on 'Edit', match: :first
    fill_in 'Name', with: @project.name + 'update'
    click_on 'Save'
    assert_text 'Project updated successfully'
  end

  test 'project member cannot update project' do
    admin_to_collaborator
    visit edit_project_path(@project)
    assert_text "Sorry, you don't have access to that"
  end

  test 'project admin can destroy project' do
    click_on @project.name
    click_on 'Edit', match: :first
    page.accept_confirm { click_on 'Delete' }
    assert_text 'Project destroyed successfully.'
  end

  test 'project member cannot destroy project' do
    admin_to_collaborator
    visit edit_project_path(@project)
    assert_text "Sorry, you don't have access to that"
  end
end

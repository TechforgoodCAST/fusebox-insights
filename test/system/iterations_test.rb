# frozen_string_literal: true

require 'application_system_test_case'

class IterationsTest < ApplicationSystemTestCase
  setup do
    @project = build(:project)
    @user = create(:user, projects: [@project])
    visit new_user_session_path
    sign_in
    click_on @project.title
  end

  test 'can draft iteration' do
    click_on 'New iteration'
    fill_in :iteration_title, with: 'Title'
    click_on 'Save as draft'

    assert_text 'Iteration saved as draft.'
  end

  test 'can commit to iteration' do
    click_on 'New iteration'
    fill_in :iteration_title, with: 'Title'
    click_link 'Add outcome'
    fill_in 'What are we going to learn or prove?', with: 'Title'
    fill_in "As a minimum, we'll know we've learnt or proved this when...", with: 'Success criteria'
    fill_in :iteration_start_date, with: Time.zone.today
    fill_in :iteration_planned_debrief_date, with: 6.weeks.since
    page.accept_confirm { click_on 'Commit to iteration' }

    assert_text 'Iteration saved.'
  end

  test 'can delete planned iteration' do
    iteration = create(:planned_iteration, project: @project)
    visit project_iteration_path(@project, iteration)
    page.accept_confirm { click_on 'Delete' }

    assert_text 'Draft iteration deleted.'
  end

  test 'cannot delete iteration once committed' do
    iteration = create(:committed_iteration, project: @project)
    visit project_iteration_path(@project, iteration)

    assert_no_link('Delete')
  end

  test 'cannot edit outcomes once committed' do
    iteration = create(:committed_iteration, project: @project)
    visit edit_project_iteration_path(@project, iteration)

    assert_no_link('Add outcome')
    assert_no_link('Remove outcome')
    assert_no_css('.iteration_outcomes_title')
  end

  test 'iterations#index redirects to projects#show' do
    visit project_iterations_path(@project)
    assert_equal(project_path(@project), current_path)
  end

  test 'iteration frequency not displayed when planned' do
    iteration = create(:iteration, project: @project)
    visit project_iteration_path(@project, iteration)

    assert_no_text('Every two weeks')
  end

  test 'iteration frequency displayed when committed' do
    iteration = create(:committed_iteration, project: @project)
    visit project_iteration_path(@project, iteration)

    assert_text('Every two weeks')
  end

  test 'contributors can view iterations' do
    Membership.last.update(role: :contributor)
    iteration = create(:committed_iteration, project: @project)
    visit project_iteration_path(@project, iteration)
    assert_text('COMMITTED')
  end

  test 'contributors can create iterations' do
    Membership.last.update(role: :contributor)
    iteration = create(:committed_iteration, project: @project)
    visit new_project_iteration_path(@project, iteration)
    assert_text('New iteration')
  end

  test 'contributors can edit iterations' do
    Membership.last.update(role: :contributor)
    iteration = create(:committed_iteration, project: @project)
    visit edit_project_iteration_path(@project, iteration)
    assert_text('Edit iteration')
  end

  test 'contributors cannot edit outcomes once committed' do
    Membership.last.update(role: :contributor)
    iteration = create(:committed_iteration, project: @project)
    visit edit_project_iteration_path(@project, iteration)

    iteration.outcomes.each_with_index do |_iteration, index|
      assert_no_selector("#iteration_outcomes_attributes_#{index}_title")
    end
  end

  test 'contributors cannot edit outcomes once completed' do
    Membership.last.update(role: :contributor)
    iteration = create(:completed_iteration, project: @project)
    visit edit_project_iteration_path(@project, iteration)

    iteration.outcomes.each_with_index do |_iteration, index|
      assert_no_selector("#iteration_outcomes_attributes_#{index}_title")
    end
  end

  test 'contributors cannot edit dates once completed' do
    Membership.last.update(role: :contributor)
    iteration = create(:completed_iteration, project: @project)
    visit edit_project_iteration_path(@project, iteration)

    assert_no_selector('#iteration_start_date')
    assert_no_selector('#iteration_planned_debrief_date')
  end

  test 'mentors can view iterations' do
    Membership.last.update(role: :mentor)
    iteration = create(:committed_iteration, project: @project)
    visit project_iteration_path(@project, iteration)
    assert_text('COMMITTED')
  end

  test 'mentors can create iterations' do
    Membership.last.update(role: :mentor)
    iteration = create(:committed_iteration, project: @project)
    visit new_project_iteration_path(@project, iteration)
    assert_text('New iteration')
  end

  test 'mentors can create outcomes once committed' do
    Membership.last.update(role: :mentor)
    iteration = create(:committed_iteration, outcomes_count: 1, project: @project)
    visit edit_project_iteration_path(@project, iteration)
    click_on 'Add outcome'
    within '#outcomes' do
      all('textarea:empty').each do |e|
        e.fill_in(with: 'New outcome')
      end
    end
    click_on 'Update Iteration'

    assert_text('New outcome', count: 2)
  end

  test 'mentors can edit iterations' do
    Membership.last.update(role: :mentor)
    iteration = create(:committed_iteration, project: @project)
    visit edit_project_iteration_path(@project, iteration)
    assert_text('Edit iteration')
  end

  test 'mentors can edit outcomes once committed' do
    Membership.last.update(role: :mentor)
    iteration = create(:committed_iteration, project: @project)
    visit edit_project_iteration_path(@project, iteration)

    iteration.outcomes.each_with_index do |_iteration, index|
      assert_selector("#iteration_outcomes_attributes_#{index}_title")
    end
  end

  test 'mentors can edit outcomes once completed' do
    Membership.last.update(role: :mentor)
    iteration = create(:completed_iteration, project: @project)
    visit edit_project_iteration_path(@project, iteration)

    iteration.outcomes.each_with_index do |_iteration, index|
      assert_selector("#iteration_outcomes_attributes_#{index}_title")
    end
  end

  test 'mentors cannot edit dates once completed' do
    Membership.last.update(role: :mentor)
    iteration = create(:completed_iteration, project: @project)
    visit edit_project_iteration_path(@project, iteration)

    assert_no_selector('#iteration_start_date')
    assert_no_selector('#iteration_planned_debrief_date')
  end

  test 'stakeholder can view iterations' do
    Membership.last.update(role: :stakeholder)
    iteration = create(:committed_iteration, project: @project)
    visit project_iteration_path(@project, iteration)
    assert_text('COMMITTED')
  end

  test 'stakeholder cannot create iterations' do
    Membership.last.update(role: :stakeholder)
    iteration = create(:committed_iteration, project: @project)
    visit new_project_iteration_path(@project, iteration)
    assert_text("Sorry, you don't have access to that")
  end

  test 'stakeholder cannot update iterations' do
    Membership.last.update(role: :stakeholder)
    iteration = create(:committed_iteration, project: @project)
    visit edit_project_iteration_path(@project, iteration)
    assert_text("Sorry, you don't have access to that")
  end
end

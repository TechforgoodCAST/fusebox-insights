# frozen_string_literal: true

require 'application_system_test_case'

class MilestonesTest < ApplicationSystemTestCase
  setup do
    @milestone = build(:milestone)
    @project = build(:project, milestones: [@milestone])
    @user = create(:user, projects: [@project])
    visit new_user_session_path
    sign_in
  end

  test 'contributor can view milestones' do
    view_milestone

    assert_equal(project_milestone_path(@project, @milestone), current_path)
  end

  test 'contributor can create milestones' do
    create_milestone

    assert_equal(project_path(@project), current_path)
    assert_text('Milestone created.')
  end

  test 'contributor can update milestones' do
    update_milestone

    assert_equal('<div>New text</div>', @milestone.success_criteria)
  end

  test 'mentor can view milestones' do
    Membership.last.update(role: :mentor)
    view_milestone

    assert_equal(project_milestone_path(@project, @milestone), current_path)
  end

  test 'mentor can create milestones' do
    Membership.last.update(role: :mentor)
    create_milestone

    assert_equal(project_path(@project), current_path)
    assert_text('Milestone created.')
  end

  test 'mentor can update milestones' do
    Membership.last.update(role: :mentor)
    update_milestone

    assert_equal('<div>New text</div>', @milestone.success_criteria)
  end

  test 'stakeholder can view milestones' do
    Membership.last.update(role: :stakeholder)
    view_milestone

    assert_equal(project_milestone_path(@project, @milestone), current_path)
  end

  test 'stakeholder cannot create milestones' do
    Membership.last.update(role: :stakeholder)
    click_on @project.title
    click_on 'milestone'

    assert_text("Sorry, you don't have access to that")
  end

  test 'stakeholder cannot update milestones' do
    Membership.last.update(role: :stakeholder)
    click_on @project.title
    click_on @milestone.title
    click_on 'Edit'

    assert_text("Sorry, you don't have access to that")
  end

  private

  def create_milestone
    click_on @project.title
    click_on 'milestone'
    fill_in :milestone_title, with: 'New milestone'
    fill_in :milestone_description, with: 'New description'
    select Date::MONTHNAMES[Time.zone.today.month]
    select Time.zone.today.year
    click_on 'Create Milestone'
  end

  def update_milestone
    click_on @project.title
    click_on @milestone.title
    click_on 'Edit'
    find('trix-editor').click.set('New text')
    click_on 'Update Milestone'
    @milestone.reload
  end

  def view_milestone
    click_on @project.title
    click_on @milestone.title
  end

  # test 'contributor can view, create and update milestones'
  # test 'mentor can view, create and update milestones'
  # test 'stakeholder can view milestones'
  # test 'stakeholder cannot create or update milestones'
  # test 'update milestone statues'
end

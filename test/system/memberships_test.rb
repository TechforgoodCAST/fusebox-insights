# frozen_string_literal: true

require 'application_system_test_case'

class MembershipsTest < ApplicationSystemTestCase
  setup do
    @project = build(:project)
    @user = create(:user, projects: [@project])
    visit new_user_session_path
    sign_in
  end

  test 'contributor can view memberships' do
    view_memberships('contributor')

    assert_equal(share_project_path(@project), current_path)
    assert_text("#{@user.full_name} (#{@user.email})")
  end

  test 'contributor can create memberships' do
    create_membership('contributor')

    assert_equal(share_project_path(@project), current_path)
    assert_text('Contributor added')
  end

  test 'contributor can destroy memberships' do
    visit share_project_path(@project)
    page.accept_confirm { click_on 'Remove' }

    assert_equal(projects_path, current_path)
    assert_text('You have been removed from the project')
  end

  test 'mentor can view memberships' do
    view_memberships('mentor')

    assert_equal(share_project_path(@project), current_path)
    assert_text("#{@user.full_name} (#{@user.email})")
  end

  test 'mentor can create memberships' do
    create_membership('mentor', add: 'contributor')

    assert_equal(share_project_path(@project), current_path)
    assert_text('Contributor added')
  end

  test 'mentor can destroy memberships' do
    @project.users << create(:user)
    @project.save!
    update_membership('mentor')
    visit share_project_path(@project)
    page.accept_confirm { click_on 'Remove' }

    assert_equal(share_project_path(@project), current_path)
    assert_text('Contributor removed')
  end

  test 'stakeholder cannot view or destroy memberships' do
    update_membership('stakeholder')
    visit share_project_path(@project)

    assert_text("Sorry, you don't have access to that")
  end

  test 'stakeholder cannot create memberships' do
    update_membership('stakeholder')
    visit new_project_membership_path(@project)

    assert_text("Sorry, you don't have access to that")
  end

  test 'user are notified when added to a project' do
    create_membership('contributor')
    mail = ActionMailer::Base.deliveries.last

    assert_equal(User.last.email, mail.to[0])
    assert_equal("You've been added to a project on Fusebox", mail.subject)
  end

  private

  def create_membership(role, add: role, project: @project, user: @user)
    update_membership(role)
    visit share_project_path(project)
    click_on "Add #{add}"
    fill_in :membership_full_name, with: user.full_name
    fill_in :membership_email, with: rand.to_s + user.email
    click_on 'Add to project'
  end

  def update_membership(role, project: @project, user: @user)
    Membership.where(project: project, user: user).update(role: role)
  end

  def view_memberships(role, project: @project, _user: @user)
    update_membership(role)
    visit share_project_path(project)
  end
end

# frozen_string_literal: true

# TODO: remove?

# require 'application_system_test_case'

# class FociTest < ApplicationSystemTestCase
#   setup do
#     @user = create(:user)
#     @project = create(:project, author: @user, users: [@user])
#     @assumption = create(:assumption, author: @user, project: @project)

#     visit new_user_session_path
#     sign_in
#   end

#   test 'view list of assumptions in focus' do
#     click_on 'navbarDropdown'
#     click_on 'My Focus'

#     assert_current_path foci_path
#   end

#   test 'add to focus' do
#     visit project_assumption_path(@project, @assumption)
#     click_on 'Focus on this assumption'

#     assert_current_path foci_path
#     assert_link @assumption.title
#   end

#   test 'remove from focus' do
#     visit project_assumption_path(@project, @assumption)
#     click_on 'Focus on this assumption'
#     click_on @assumption.title
#     click_on 'Remove focus'

#     assert_current_path project_assumption_path(@project, @assumption)
#     assert_link 'Focus on this assumption'
#   end
# end

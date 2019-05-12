# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1280, 700]

  def admin_to_collaborator(user: @user, project: @project)
    user.project_members.find_by(project: project).update!(role: 'Collaborator')
  end

  def sign_in(user = @user)
    fill_in(:user_email, with: user.email)
    fill_in(:user_password, with: user.password)
    click_button('Sign in')
  end

  def sign_out
    click_link('navbarDropdown')
    click_link('Sign out')
  end
end

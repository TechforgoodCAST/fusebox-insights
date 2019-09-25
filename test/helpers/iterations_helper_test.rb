# frozen_string_literal: true

require 'test_helper'

class IterationsHelperTest < ActionView::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @iteration = create(:iteration)
    @user = create(:user)
    sign_in(@user)
  end

  test '#mentor_membership not found' do
    assert_nil(mentor_membership)
  end

  test '#mentor_membership found' do
    create(:membership, project: @iteration.project, user: @user, role: :mentor)
    assert(mentor_membership)
  end

  test '#render_warning invalid key' do
    assert_nil(render_warning(nil, @iteration))
    assert_nil(render_warning(:missing, @iteration))
  end

  test '#render_warning :check_in_due' do
    html = Nokogiri::HTML(render_warning(:check_in_due, @iteration))

    assert_includes(html.css('span').text, 'Over two weeks since last check in. ')
    assert_includes(html.css('.link').text, 'Add a check-in')
    assert_includes(html.css('.link')[0]['href'], new_project_iteration_check_in_path(@iteration.project, @iteration))
  end

  test '#render_warning :debrief_due' do
    html = Nokogiri::HTML(render_warning(:debrief_due, @iteration))

    assert_includes(html.css('.notice').text, 'Debrief overdue. Add a debrief')
  end

  private

  def current_user
    @user
  end
end

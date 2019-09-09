# frozen_string_literal: true

require 'test_helper'

class IterationsHelperTest < ActionView::TestCase
  setup do
    @iteration = create(:iteration)
  end

  test '#render_warning invalid key' do
    assert_nil(render_warning(nil))
    assert_nil(render_warning(:missing))
  end

  test '#render_warning :check_in_due' do
    html = Nokogiri::HTML(render_warning(:check_in_due))

    assert_includes(html.css('span').text, 'Over two weeks since last check in. ')
    assert_includes(html.css('.link').text, 'Add a check in')
    assert_includes(html.css('.link')[0]['href'], new_project_iteration_check_in_path(@iteration.project, @iteration))
  end

  test '#render_warning :debrief_due' do
    html = Nokogiri::HTML(render_warning(:debrief_due))

    assert_includes(html.css('.notice').text, 'Debrief overdue. Add a debrief')
  end
end

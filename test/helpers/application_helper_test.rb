# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test '#active_tab? controller active' do
    assert_equal('active', active_tab?(controller: 'test'))
  end

  test '#active_tab? controller inactive' do
    assert_nil(active_tab?(controller: 'oops'))
  end

  test '#active_tab? controller active and action active' do
    assert_equal('active', active_tab?(controller: 'test', action: 'new'))
  end

  test '#active_tab? controller active and action inactive' do
    assert_nil(active_tab?(controller: 'test', action: 'oops'))
  end

  test '#active_tab? controller inactive and action active' do
    assert_nil(active_tab?(controller: 'oops', action: 'new'))
  end

  test '#active_tab? controller inactive and action inactive' do
    assert_nil(active_tab?(controller: 'oops', action: 'oops'))
  end

  test 'friendly_date' do
    assert_raise(Exception) { friendly_date('x') }
    assert_raise(Exception) { friendly_date('1st Jan 2019') }
    assert_raise(Exception) { friendly_date(1234) }
    assert_nothing_raised { friendly_date(Time.zone.today) }
    assert_nothing_raised { friendly_date(DateTime.now) }
  end

  test '#with_default displays default text when value missing' do
    assert_equal('<span class="missing-text">Not set</span>', with_default(nil))
    assert_equal('<span class="missing-text">Not set</span>', with_default(''))
  end

  test '#with_default displays custom text when value missing' do
    assert_match('Missing!', with_default('', text: 'Missing!'))
  end

  test '#with_default displays value when present' do
    assert_equal('Value', with_default('Value'))
  end

  test '#with_default displays and formats value when present' do
    assert_equal('<p>Value</p>', with_default('Value', formatter: :simple_format))
  end

  private

  def action_name
    super
    'new'
  end
end

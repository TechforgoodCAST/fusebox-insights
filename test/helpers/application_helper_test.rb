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

  private

  def action_name
    super
    'new'
  end
end

# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test '#current_controller? active' do
    assert_equal('active', current_controller?('test'))
  end

  test '#current_controller? inactive' do
    assert_nil(current_controller?('oops'))
  end
end

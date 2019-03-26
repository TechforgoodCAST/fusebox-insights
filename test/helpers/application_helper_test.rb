# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test '#current_controller? active' do
    assert_equal('active', current_controller?('test'))
  end

  test '#current_controller? inactive' do
    assert_nil(current_controller?('oops'))
  end

  test '#vote_path' do
    path = '/unknowns/1?confidence=none#new_response'
    assert_equal(path, vote_path(1, 'none'))
  end
end

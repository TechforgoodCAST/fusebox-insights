# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  attr_reader :request

  setup { request.path = '/' }

  test('#current_path? active') { assert_equal('active', current_path?('/')) }

  test('#current_path? inactive') { assert_equal(nil, current_path?('/oops')) }

  test '#vote_path' do
    path = '/unknowns/1?confidence=none#new_comment'
    assert_equal(path, vote_path(1, 'none'))
  end
end

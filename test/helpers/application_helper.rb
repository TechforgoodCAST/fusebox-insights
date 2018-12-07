# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  attr_reader :request

  setup { request.path = '/' }

  test('#current_path? active') { assert_equal('active', current_path?('/')) }

  test('#current_path? inactive') { assert_equal(nil, current_path?('/oops')) }
end

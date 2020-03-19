# frozen_string_literal: true

require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  setup { @subject = build(:topic) }

  test('title required') { assert_present(:title) }

  test('short desc required') { assert_present(:short_desc) }

  test('long desc required') { assert_present(:long_desc) }
end

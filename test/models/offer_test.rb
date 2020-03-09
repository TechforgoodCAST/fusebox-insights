# frozen_string_literal: true

require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  setup { @subject = build(:offer) }

  test 'belongs to provider' do
    assert_instance_of(Provider, @subject.provider)
    assert_present(:provider, msg: 'must exist')
  end

  test('title required') { assert_present(:title) }

  test('duration_category required') { assert_present(:duration_category) }

  test('duration_description required') { assert_present(:duration_description) }
end

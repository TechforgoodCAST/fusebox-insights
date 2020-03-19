# frozen_string_literal: true

require 'test_helper'

class ProviderTest < ActiveSupport::TestCase
  setup { @subject = build(:provider) }

  test('has many offers') { assert_has_many(:offers) }

  test('dependent destroys offers') { assert_destroys(:offers) }

  test('name required') { assert_present(:name) }

  test('website required') { assert_present(:website) }

  test 'website format' do
    @subject.website = nil
    @subject.save
    msg = 'enter a valid website address e.g. http://www.example.com'
    assert_error(:website, msg)
  end
end

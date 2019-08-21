require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  setup { @subject = build(:rating) }

  test 'belongs to outcome' do
    assert_instance_of(Outcome, @subject.outcome)
    assert_present(:outcome, msg: 'must exist')
  end
  
  test 'belongs to check in' do
    assert_instance_of(CheckIn, @subject.check_in)
    assert_present(:check_in, msg: 'must exist')
  end
  
  test('score required') { assert_present(:score) }
  
  test('comments required') { assert_present(:comments) }
end

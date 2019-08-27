require 'test_helper'

class CheckInTest < ActiveSupport::TestCase
  setup { @subject = build(:check_in) }

  test 'belongs to iteration' do
    assert_instance_of(Iteration, @subject.iteration)
    assert_present(:iteration, msg: 'must exist')
  end
	
  test('complete at timestamp required') { assert_present(:complete_at) }
  
end

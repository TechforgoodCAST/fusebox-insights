require 'test_helper'

class DebriefTest < ActiveSupport::TestCase
  setup { @subject = build(:debrief) }

  test 'belongs to iteration' do
    assert_instance_of(Iteration, @subject.iteration)
    assert_present(:iteration, msg: 'must exist')
  end
	
  test('complete at timestamp required') { assert_present(:complete_at) }
  
  test('completed_by required') { assert_present(:completed_by) }
  
  test('milestone_completed required') { assert_present(:milestone_completed) }
  
end

require 'test_helper'

class OutcomeTest < ActiveSupport::TestCase
  setup { @subject = build(:outcome) }

  test 'belongs to iteration' do
    assert_instance_of(Iteration, @subject.iteration)
    assert_present(:iteration, msg: 'must exist')
  end
  
  test('title required') { assert_present(:title) }
  
  test('description required') { assert_present(:description) }
end

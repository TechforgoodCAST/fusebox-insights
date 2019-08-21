require 'test_helper'

class IterationTest < ActiveSupport::TestCase
  setup { @subject = build(:iteration) }

  test 'belongs to project' do
    assert_instance_of(Project, @subject.project)
    assert_present(:project, msg: 'must exist')
  end
  
  test('has many outcomes') { assert_has_many(:outcomes) }
  
  test('has many check-ins') { assert_has_many(:check_ins) }
  
  test('title required') { assert_present(:title) }
  
  test('description required') { assert_present(:description) }

  test('start date required') { assert_present(:start_date) }
  
  test('debrief date required') { assert_present(:debrief_date) }

  test('status required') { assert_present(:status) }
end

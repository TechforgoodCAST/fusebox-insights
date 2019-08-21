require 'test_helper'

class IterationTest < ActiveSupport::TestCase
  setup { @subject = build(:iteration) }

  test 'belongs to project' do
    assert_instance_of(Project, @subject.project)
    assert_present(:project, msg: 'must exist')
  end
  
  test('has many outcomes') { assert_has_many(:outcomes) }
  
  test('has many check-ins') { assert_has_many(:check_ins) }
  
  test('title required') do 
    assert_present(:title)
  end
  
  test('description required when committing') do
    @subject.committing = true
    assert_present(:description)
  end

  test('start date required when committing') do
    @subject.committing = true
    assert_present(:start_date)
  end
  
  test('debrief date required when committing') do
    @subject.committing = true
    assert_present(:debrief_date)
  end
end

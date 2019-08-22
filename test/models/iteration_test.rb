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

  test('start date required when committing') do
    @subject.committing = true
    assert_present(:start_date)
  end
  
  test('debrief date required when committing') do
    @subject.committing = true
    assert_present(:debrief_date)
  end
  
  test('start date defaults to today') do
    assert_equal(Date.today, @subject.start_date)
  end
  
  test("start date can't be in the past") do 
    @subject.start_date = Date.yesterday
    @subject.valid?
    assert_error(:start_date, "Can't be in the past")
  end
  
  test("debrief date can't be before start date") do 
    @subject.start_date = Date.today
    @subject.debrief_date = Date.yesterday
    @subject.valid?
    assert_error(:debrief_date, "Can't be before start date")
  end
  
  test("iteration can't be shorter than 2 weeks") do 
    @subject.start_date = Date.today
    @subject.debrief_date = 1.weeks.since
    @subject.valid?
    assert_error(:debrief_date, "Iteration can't be shorter than 2 weeks")
  end
  
  test("iteration can't be longer than 12 weeks") do 
    @subject.start_date = Date.today
    @subject.debrief_date = 13.weeks.since
    @subject.valid?
    assert_error(:debrief_date, "Iteration can't be longer than 12 weeks")
  end
end

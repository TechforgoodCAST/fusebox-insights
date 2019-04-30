# frozen_string_literal: true

require 'test_helper'

class ReflectionTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    create_list(:focus, 2, user: @user)
    @subject = Reflection.new(author: @user)
  end

  test 'initialize without author' do
    @subject = Reflection.new
    assert_equal(0, @subject.responses.size)
  end

  test 'initialize with author builds repsonses' do
    assert_equal(2, @subject.responses.size)
    @subject.responses.each { |response| assert_kind_of(Response, response) }
  end

  test '#save invalid' do
    @subject.responses = { '0' => { 'confidence' => '1', 'type' => 'Insight', 'description' => 'A reason' } }
    assert_not(@subject.save)
  end

  test '#save valid' do
    assert_equal(0, Insight.count)
    assert_equal(0, Proof.count)

    @subject.responses = { '0' => { 'confidence' => '1', 'title' => 'title', 'type' => 'Insight', 'description' => 'A reason' } }
    assert(@subject.save)

    assert_equal(1, Insight.count)
    assert_equal(1, Proof.count)
  end

  test '#unknowns default' do
    @subject = Reflection.new
    assert_equal(0, @subject.unknowns.size)
  end

  test '#unknowns with author' do
    assert_equal(2, @subject.unknowns.size)
    @subject.unknowns.each { |unknown| assert_kind_of(Unknown, unknown) }
  end
end

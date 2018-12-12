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
    assert_equal(0, @subject.comments.size)
  end

  test 'initialize with author builds comments' do
    assert_equal(2, @subject.comments.size)
    @subject.comments.each { |comment| assert_kind_of(Comment, comment) }
  end

  test '#save invalid' do
    @subject.comments = { '0' => { 'confidence' => '1', 'title' => '' } }
    refute(@subject.save)
  end

  test '#save valid' do
    assert_equal(0, Insight.count)
    assert_equal(0, Proof.count)

    @subject.comments = { '0' => { 'confidence' => '1', 'title' => 'title' } }
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
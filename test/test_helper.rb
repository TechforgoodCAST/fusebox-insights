# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def assert_authorised(methods, subject: @subject, permitted: true)
    methods.each do |method|
      permitted ? assert(subject.send(method)) : assert_not(subject.send(method))
    end
  end

  def assert_destroys(key, count: 1, subject: @subject)
    subject.send("#{key}=", create_list(key.to_s.singularize.to_sym, count))
    subject.save!
    assert_equal(count, subject.send(key).count)
    @subject.destroy
    assert_equal(0, subject.send(key).count)
  end

  def assert_error(key, msg, subject: @subject)
    assert_includes(subject.errors[key], msg)
  end

  def assert_has_many(key, count: 2, subject: @subject)
    subject.send("#{key}=", create_list(key.to_s.singularize.to_sym, count))
    subject.save!
    assert_equal(count, subject.send(key).count)
  end

  def assert_present(key, msg: "can't be blank", subject: @subject, value: nil)
    subject.send("#{key}=", value)
    subject.valid?
    assert_error(key, msg)
  end

  def assert_unique(key, msg: 'has already been taken', subject: @subject)
    subject.save!
    dup = subject.dup
    dup.valid?
    assert_error(key, msg, subject: dup)
  end
end

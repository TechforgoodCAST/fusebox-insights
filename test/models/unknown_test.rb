require 'test_helper'

class UnknownTest < ActiveSupport::TestCase
  setup { @subject = build(:unknown, author: build(:user)) }

  test('belongs to #author') { assert_kind_of(User, @subject.author) }

  test('#title present') { assert_present(:title) }

  test('valid') { assert(@subject.valid?) }
end

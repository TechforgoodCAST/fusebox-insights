# frozen_string_literal: true

require 'test_helper'

class ProofTest < ActiveSupport::TestCase
  setup { @subject = build(:proof) }

  test('belongs to #author') { assert_kind_of(User, @subject.author) }

  test('belongs to #insight') { assert_kind_of(Insight, @subject.insight) }

  test('belongs to #unknown') { assert_kind_of(Assumption, @subject.unknown) }
end

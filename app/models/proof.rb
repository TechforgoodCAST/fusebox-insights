# frozen_string_literal: true

# TODO: remove (& from db) after v0.2.0
class Proof < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :insight
  belongs_to :assumption
end

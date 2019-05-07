# frozen_string_literal: true

class Proof < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :insight
  belongs_to :assumption
end

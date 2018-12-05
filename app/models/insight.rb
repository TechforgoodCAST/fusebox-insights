# frozen_string_literal: true
class Insight < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :title, presence: true, uniqueness: { scope: :author }
end

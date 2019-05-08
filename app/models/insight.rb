# frozen_string_literal: true

class Insight < ApplicationRecord
  include PgSearch

  multisearchable against: [:title]

  belongs_to :author, class_name: 'User'
  belongs_to :assumption, optional: true

  validates :title, presence: true, uniqueness: { scope: :author }
end

# frozen_string_literal: true

class Insight < ApplicationRecord
  include PgSearch

  multisearchable against: [:title]

  belongs_to :author, class_name: 'User'

  has_many :proofs, dependent: :destroy
  has_many :assumptions, through: :proofs

  validates :title, presence: true, uniqueness: { scope: :author }
end

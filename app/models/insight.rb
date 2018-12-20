# frozen_string_literal: true
class Insight < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :proofs, dependent: :destroy
  has_many :unknowns, through: :proofs

  validates :title, presence: true, uniqueness: { scope: :author }
end

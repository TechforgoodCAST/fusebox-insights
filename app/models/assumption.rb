# frozen_string_literal: true

class Assumption < ApplicationRecord
  include PgSearch
  include Triggerable

  DAMAGE = [
    'Low - being wrong about this will have little to no effect',
    'Medium - being wrong about this will have a moderate effect',
    'High - being wrong about this will have a significant effect'
  ].freeze

  acts_as_paranoid
  audited

  enum certainty: { we_do_not_know: 0, we_think_we_know: 1, we_know: 2 }
  enum damage: { low: 0, medium: 1, high: 2 }

  multisearchable against: [:title]

  belongs_to :author, class_name: 'User'
  belongs_to :group, optional: true
  belongs_to :project

  has_many :comments, dependent: :destroy
  has_many :insights, dependent: :destroy

  has_many :foci, dependent: :destroy
  has_many :focussed_by, through: :foci, source: :user

  validates :title, presence: true, uniqueness: { scope: :project }

  def responses
    (comments + insights).sort_by(&:updated_at).reverse
  end
end

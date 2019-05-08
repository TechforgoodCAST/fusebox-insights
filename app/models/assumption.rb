# frozen_string_literal: true

class Assumption < ApplicationRecord
  include PgSearch
  include Triggerable

  acts_as_paranoid
  audited

  enum certainty: %i[we_do_not_know we_think_we_know we_know]

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
    (comments + insights).sort_by(&:updated_at)
  end
end

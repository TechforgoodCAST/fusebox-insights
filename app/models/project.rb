# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :user

  has_many :project_members
  has_many :users, through: :project_members

  validates :name, presence: true, uniqueness: { scope: :user }
  validates :slug, uniqueness: true
  validates :is_private, inclusion: { in: [true, false] }, allow_nil: false

  before_validation :generate_slug, unless: :slug

  def to_param
    slug
  end

  private

  def generate_slug
    self[:slug] = name.parameterize
  end
end

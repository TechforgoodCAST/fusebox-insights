# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :cohort

  has_many :iterations, dependent: :destroy
  has_many :milestones, dependent: :destroy

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :description, :title, presence: true

  audited
end

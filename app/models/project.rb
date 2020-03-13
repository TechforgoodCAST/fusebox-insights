# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :cohort, optional: true
  has_many :offers, through: :cohort
  has_many :topics, through: :offers

  has_many :iterations, dependent: :destroy
  has_many :milestones, dependent: :destroy

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_many :support_requests, dependent: :destroy

  validates :description, :title, presence: true

  audited
end

# frozen_string_literal: true

class Project < ApplicationRecord
  # TODO: belongs_to :owner, class_name: 'User'

  has_many :iterations, dependent: :destroy
  has_many :milestones, dependent: :destroy

  # TODO: has_many :memberships, dependent: :destroy
  # TODO: has_many :users, through: :memberships

  validates :title, presence: true
end

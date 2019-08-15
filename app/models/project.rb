# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :iterations, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :milestones, dependent: :destroy

  validates :description, :title, presence: true
end

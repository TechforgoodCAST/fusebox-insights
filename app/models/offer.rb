# frozen_string_literal: true

class Offer < ApplicationRecord
  belongs_to :provider
  has_and_belongs_to_many :cohorts
  has_and_belongs_to_many :topics
  has_many :support_requests

  enum duration_category: { small: 0, medium: 1, large: 2 }

  validates :title, :duration_category, :duration_description, presence: true
end

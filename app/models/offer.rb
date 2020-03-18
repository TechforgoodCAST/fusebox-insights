# frozen_string_literal: true

class Offer < ApplicationRecord
  belongs_to :provider
  has_and_belongs_to_many :cohorts
  has_and_belongs_to_many :topics
  has_many :support_requests

  enum duration_category: { 'Get started': 0, 'Dive deeper': 1, 'Other': 2 }

  validates :title, :duration_category, :duration_description, :provider_email, presence: true
end

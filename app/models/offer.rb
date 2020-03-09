# frozen_string_literal: true

class Offer < ApplicationRecord
  belongs_to :provider

  enum duration_category: { small: 0, medium: 1, large: 2 }

  validates :title, :duration_category, :duration_description, presence: true
end

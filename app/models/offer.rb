# frozen_string_literal: true

class Offer < ApplicationRecord
  belongs_to :provider

  validates :title, presence: true
end

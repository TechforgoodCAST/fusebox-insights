# frozen_string_literal: true

class Provider < ApplicationRecord
  has_many :offers, dependent: :destroy

  validates :name, :website, presence: true

  validates :website, format: {
    with: URI.regexp(%w[http https]),
    message: 'enter a valid website address e.g. http://www.example.com'
  }
end

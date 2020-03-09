# frozen_string_literal: true

class Provider < ApplicationRecord
  has_many :offers, dependent: :destroy

  validates :name, :website, presence: true
end

# frozen_string_literal: true

class Focus < ApplicationRecord
  belongs_to :unknown
  belongs_to :user

  validates :unknown, uniqueness: { scope: :user }
end

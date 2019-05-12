# frozen_string_literal: true

class Focus < ApplicationRecord
  belongs_to :assumption
  belongs_to :user

  validates :assumption, uniqueness: { scope: :user }
end

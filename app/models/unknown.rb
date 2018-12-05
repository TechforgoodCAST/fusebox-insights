# frozen_string_literal: true

class Unknown < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :foci, dependent: :destroy
  has_many :focussed_by, through: :foci, source: :user

  validates :title, presence: true, uniqueness: { scope: :author }
end

# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :unknowns
  validates :title, presence: true
end

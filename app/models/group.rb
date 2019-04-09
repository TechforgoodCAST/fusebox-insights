# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :project
  
  has_many :unknowns
  validates :title, presence: true
end

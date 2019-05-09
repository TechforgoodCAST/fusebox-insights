# frozen_string_literal: true

class Group < ApplicationRecord
  acts_as_paranoid

  belongs_to :author, class_name: 'User'
  belongs_to :project

  has_many :assumptions, dependent: :nullify

  validates :title, presence: true, uniqueness: { scope: :project }
end

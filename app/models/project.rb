# frozen_string_literal: true

class Project < ApplicationRecord
  extend FriendlyId

  acts_as_paranoid
  friendly_id :name, use: :slugged

  belongs_to :author, class_name: 'User'

  has_many :project_members
  has_many :users, through: :project_members

  has_many :support_messages
  has_many :events
  has_many :groups, dependent: :destroy
  has_many :assumptions

  validates :name, presence: true, uniqueness: { scope: :author }
  validates :is_private, inclusion: { in: [true, false] }, allow_nil: false

  after_create :create_default_groups

  private

  def create_default_groups
    if groups.empty?
      groups.create!(
        [
          { title: 'Problem Statement', author: author },
          { title: 'Problem Area', author: author },
          { title: 'User Value', author: author },
          { title: 'Social Value', author: author },
          { title: 'Financial Value', author: author }
        ]
      )
    end
  end
end

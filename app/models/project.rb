# frozen_string_literal: true

class Project < ApplicationRecord

  acts_as_paranoid
  
  extend FriendlyId
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
      if self.groups.empty?
        self.groups.create!([
          { title: "Problem Statement", author: self.author },
          { title: "Problem Area", author: self.author },
          { title: "User Value", author: self.author },
          { title: "Social Value", author: self.author },
          { title: "Financial Value", author: self.author }
        ])
      end
    end

end

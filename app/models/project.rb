# frozen_string_literal: true

class Project < ApplicationRecord

  belongs_to :author, class_name: 'User'

  has_many :project_members
  has_many :users, through: :project_members
  has_many :support_messages
  has_many :events
  has_many :groups, dependent: :destroy
  has_many :unknowns

  validates :name, presence: true, uniqueness: { scope: :author }
  validates :slug, uniqueness: true
  validates :is_private, inclusion: { in: [true, false] }, allow_nil: false

  before_validation :generate_slug, unless: :slug
  after_create :create_default_groups

  def to_param
    slug
  end

  private

    def generate_slug
      self[:slug] = name.parameterize
    end

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

class Project < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :support_messages, foreign_key: 'project_id'
  validates :slug, uniqueness: true
end

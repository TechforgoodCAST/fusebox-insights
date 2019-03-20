class Project < ApplicationRecord
    belongs_to :user, class_name: 'User'
    validates :slug, uniqueness: true
end

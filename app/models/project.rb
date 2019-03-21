class Project < ApplicationRecord
  belongs_to :user, class_name: 'User'
  validates :slug, uniqueness: true
  
  def generate_slug
    self.slug = self.name.parameterize
  end

end

class Project < ApplicationRecord
  before_validation :generate_slug
  belongs_to :user, class_name: 'User'
  validates :slug, uniqueness: true

  def to_param
    slug
  end

  private

    def generate_slug
      self.slug = self.name.parameterize
    end
  
end

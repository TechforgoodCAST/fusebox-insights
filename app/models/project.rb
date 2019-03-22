class Project < ApplicationRecord
  before_validation :generate_slug
  belongs_to :user
  validates :name, presence: true, uniqueness: {scope: :user}
  validates :slug, uniqueness: true
  validates :is_private, inclusion: { in: [ true, false ] },  allow_nil: false

  def to_param
    slug
  end
  
  def generate_slug
    self.slug = self.name.parameterize
  end
  
end

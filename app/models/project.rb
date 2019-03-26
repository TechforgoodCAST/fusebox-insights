class Project < ApplicationRecord
  before_validation :generate_slug
  
  belongs_to :user
  
  has_many :project_members
  has_many :users, :through => :project_members
  has_many :support_messages
  
  validates :name, presence: true, uniqueness: {scope: :user}
  validates :slug, uniqueness: true
  validates :is_private, inclusion: { in: [ true, false ] },  allow_nil: false

  def to_param
    slug
  end
  
  def generate_slug
    # only generate slug if no existing slug
    if self.slug.blank?
      self.slug = self.name.parameterize
    end
  end
  
end

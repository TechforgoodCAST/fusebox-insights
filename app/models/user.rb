# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
         :registerable, :trackable

  attr_accessor :current_sign_in_ip, :last_sign_in_ip

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  validates :full_name, presence: true

  def is_project_member?(project, roles = %w[contributor mentor stakeholder])
    Membership.find_by(project: project, user: self, role: roles)
  end

  private

  # Prevent Devise trackable module from recording IP addresses.
  def update_tracked_fields(request)
    super(request)
    self.last_sign_in_ip = nil
    self.current_sign_in_ip = nil
  end
end

# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
         :registerable, :trackable, :omniauthable, omniauth_providers: [:google_oauth2]
  
  attr_accessor :current_sign_in_ip, :last_sign_in_ip

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships

  validates :full_name, presence: true
  
  def self.from_omniauth(access_token)
      data = access_token.info
      user = User.where(email: data['email']).first

      # Uncomment the section below if you want users to be created if they don't exist
      # unless user
      #     user = User.create(name: data['name'],
      #        email: data['email'],
      #        password: Devise.friendly_token[0,20]
      #     )
      # end
      user
  end

  private

  # Prevent Devise trackable module from recording IP addresses.
  def update_tracked_fields(request)
    super(request)
    self.last_sign_in_ip = nil
    self.current_sign_in_ip = nil
  end
end

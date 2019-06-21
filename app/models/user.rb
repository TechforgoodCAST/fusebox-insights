# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable

  has_many :assumptions, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :events, foreign_key: 'user_id', dependent: :destroy, inverse_of: :user
  has_many :groups, foreign_key: 'author_id'
  has_many :insights, foreign_key: 'author_id'

  has_many :foci, dependent: :destroy
  has_many :in_focus, through: :foci, source: :assumption

  has_many :memberships
  has_many :projects, through: :memberships

  validates :username, presence: true
  
  def initials
    username.split('')[0]
  end
end

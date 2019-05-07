# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable

  has_many :insights, foreign_key: 'author_id'
  has_many :proofs, foreign_key: 'author_id'
  has_many :assumptions, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :events, foreign_key: 'user_id', dependent: :destroy, inverse_of: :user
  has_many :groups, foreign_key: 'author_id'

  has_many :foci, dependent: :destroy
  has_many :in_focus, through: :foci, source: :assumption

  has_many :project_members
  has_many :projects, through: :project_members

  validates :username, presence: true
end

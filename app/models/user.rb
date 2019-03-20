# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :insights, foreign_key: 'author_id'
  has_many :proofs, foreign_key: 'author_id'
  has_many :unknowns, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'

  has_many :foci, dependent: :destroy
  has_many :in_focus, through: :foci, source: :unknown
  has_many :projects, foreign_key: 'user_id'

  validates :username, presence: true
end

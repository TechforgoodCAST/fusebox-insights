# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :insights, foreign_key: 'author_id'
  has_many :unknowns, foreign_key: 'author_id'

  validates :username, presence: true
end

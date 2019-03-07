# frozen_string_literal: true

class Unknown < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :foci, dependent: :destroy
  has_many :focussed_by, through: :foci, source: :user

  has_many :proofs, dependent: :destroy
  has_many :insights, through: :proofs
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :author }
end

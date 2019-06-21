# frozen_string_literal: true

class Project < ApplicationRecord
  extend FriendlyId

  acts_as_paranoid
  friendly_id :name, use: :slugged

  belongs_to :author, class_name: 'User'

  has_many :assumptions, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :insights, dependent: :destroy
  has_many :support_messages, dependent: :destroy

  # TODO: rename to memberships & test destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: { scope: :author }
  validates :is_private, inclusion: { in: [true, false] }, allow_nil: false

  after_create { GroupFactory.new(author, self).create! if groups.empty? }
end

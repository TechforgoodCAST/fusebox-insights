# frozen_string_literal: true

class Membership < ApplicationRecord
  attr_accessor :email, :full_name

  enum role: { contributor: 0, stakeholder: 1, mentor: 2 }

  belongs_to :project
  belongs_to :user

  validates :role, presence: true
  validates :project, uniqueness: {
    scope: :user, message: 'this email has already been added to the project'
  }

  validate :display_duplicate_email_error

  def save_with_user
    lookup = find_or_create_user
    if lookup.persisted?
      self.user = lookup
      save
    end
  end

  private

  def display_duplicate_email_error
    errors.add(:email, errors[:project].first) if errors[:project].any?
  end

  def find_or_create_user
    lookup = User.find_or_initialize_by(email: email&.strip)

    if lookup.new_record?
      lookup.full_name = full_name
      lookup.password = SecureRandom.urlsafe_base64

      unless lookup.save
        errors.add(:full_name, lookup.errors[:full_name].first)
        errors.add(:email, lookup.errors[:email].first)
      end
    end

    lookup
  end
end

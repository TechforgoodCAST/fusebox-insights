# frozen_string_literal: true

class Unknown < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :title, presence: true, uniqueness: { scope: :author }
end

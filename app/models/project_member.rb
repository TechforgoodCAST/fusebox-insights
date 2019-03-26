# frozen_string_literal: true

class ProjectMember < ApplicationRecord
  belongs_to :user
  belongs_to :project
end

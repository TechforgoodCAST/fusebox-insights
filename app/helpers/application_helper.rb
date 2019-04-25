# frozen_string_literal: true

module ApplicationHelper
  def current_controller?(controller)
    controller_name == controller ? 'active' : nil
  end

  def vote_path(unknown, confidence)
    project_unknown_path(unknown.project, unknown, confidence: confidence, anchor: 'new_response')
  end
end

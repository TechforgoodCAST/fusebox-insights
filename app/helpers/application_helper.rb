# frozen_string_literal: true

module ApplicationHelper
  def current_controller?(controller)
    controller_name == controller ? 'active' : nil
  end

  def vote_path(unknown, confidence)
    unknown_path(unknown, confidence: confidence, anchor: 'new_comment')
  end
end

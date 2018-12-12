# frozen_string_literal: true

module ApplicationHelper
  def current_path?(path)
    current_page?(path) ? 'active' : nil
  end

  def vote_path(unknown, confidence)
    unknown_path(unknown, confidence: confidence, anchor: 'new_comment')
  end
end

# frozen_string_literal: true

module ApplicationHelper
  def current_action?(action)
    action_name == action ? 'active' : nil
  end

  def current_controller?(controller)
    controller_name == controller ? 'active' : nil
  end
end

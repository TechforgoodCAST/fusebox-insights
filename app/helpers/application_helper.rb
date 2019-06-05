# frozen_string_literal: true

module ApplicationHelper
  def current_controller?(controller)
    controller_name == controller ? 'active' : nil
  end
end

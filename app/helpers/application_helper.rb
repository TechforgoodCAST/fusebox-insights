# frozen_string_literal: true

module ApplicationHelper
  def active_tab?(controller: nil, action: nil)
    if action
      controller_name == controller && action_name == action ? 'active' : nil
    else
      controller_name == controller ? 'active' : nil
    end
  end
end

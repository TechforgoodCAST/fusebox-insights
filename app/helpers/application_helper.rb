# frozen_string_literal: true

module ApplicationHelper
  def active_tab?(controller: nil, action: nil)
    if action
      controller_name == controller && action_name == action ? 'active' : nil
    else
      controller_name == controller ? 'active' : nil
    end
  end

  # TODO: test
  def friendly_date(date)
    raise "#{date} is a #{date.class} and not a Date" unless date.is_a?(Date)

    date.strftime("#{date.day.ordinalize} %b %Y")
  end
end

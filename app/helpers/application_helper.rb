# frozen_string_literal: true

module ApplicationHelper
  YESNO = { 0 => 'No', 1 => 'Yes' }.freeze

  def active_tab?(controller: nil, action: nil)
    if action
      controller_name == controller && action_name == action ? 'active' : nil
    else
      controller_name == controller ? 'active' : nil
    end
  end

  def friendly_date(date)
    raise "#{date} is a #{date.class} and not a date" unless date.respond_to?(:strftime)

    date.strftime("#{date.day.ordinalize} %b %Y")
  end

  def with_default(value, text: 'Not set', formatter: nil)
    if value.blank?
      tag.span(text, class: 'missing-text')
    else
      formatter ? send(formatter, value) : value
    end
  end
end

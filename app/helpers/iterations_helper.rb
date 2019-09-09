# frozen_string_literal: true

module IterationsHelper
  def render_warning(key)
    case key
    when :check_in_due
      tag.div class: 'notice danger my-4' do
        tag.span('Over two weeks since last check in. ') +
          tag.a('Add a check in', href: new_project_iteration_check_in_path(@iteration.project, @iteration), class: 'link')
      end
    when :debrief_due
      tag.div(class: 'notice danger my-4') { 'Debrief overdue. Add a debrief' }
    end
  end
end

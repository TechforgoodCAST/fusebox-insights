# frozen_string_literal: true

module IterationsHelper
  def mentor_membership
    Membership.find_by(project: @iteration.project, user: current_user, role: :mentor)
  end

  def render_warning(key, iteration)
    case key
    when :check_in_due
      tag.div class: 'notice danger my-4' do
        tag.span('Over two weeks since last check in. ') +
          tag.a('Add a check-in', href: new_project_iteration_check_in_path(iteration.project, iteration), class: 'link')
      end
    when :debrief_due
      tag.div(class: 'notice danger my-4') do
        tag.span('Debrief overdue. ') +
          tag.a('Add a debrief', href: new_project_iteration_debrief_path(iteration.project, iteration), class: 'link')
      end
    end
  end
end

# frozen_string_literal: true

class IterationNotifier < Iteration
  def initialize(iteration = nil)
    super(iteration&.attributes)
  end

  def send_notification!
    message = which_notification
    if message
      NotificationsMailer.send(message, self).deliver_now
      Rails.logger.info("[#{Time.zone.now}] #{message} sent for iteration #{id}")
    else
      Rails.logger.info("[#{Time.zone.now}] Nothing sent for iteration #{id}")
    end
  end

  private

  def send_check_in?(check_in_gap, debrief_gap)
    check_in_distance == check_in_gap && debrief_distance > debrief_gap
  end

  def which_notification(check_in_gap: -14, debrief_gap: 7, overdue_gap: -3)
    return unless status_committed?

    return :check_in_due if send_check_in?(check_in_gap, debrief_gap)

    return :check_in_overdue if send_check_in?(check_in_gap + overdue_gap, debrief_gap)

    return :debrief_due if planned_debrief_date == Time.zone.today

    return :debrief_overdue if debrief_distance == overdue_gap
  end
end

# frozen_string_literal: true

namespace :scheduler do
  desc 'send notifications for iterations'
  task notify: :environment do
    Iteration.status_committed.find_each do |iteration|
      message = iteration.which_notification
      if message
        NotificationsMailer.send(message, iteration).deliver_now
        Rails.logger.info("[#{Time.zone.now}] #{message} sent for iteration #{iteration.id}")
      else
        Rails.logger.info("[#{Time.zone.now}] Nothing sent for iteration #{iteration.id}")
      end
    end
  end
end

# frozen_string_literal: true

namespace :scheduler do
  desc 'send notifications for iterations'
  task notify: :environment do
    IterationNotifier.status_committed.find_each(&:send_notification!)
  end
end

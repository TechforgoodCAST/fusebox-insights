module Triggerable
  extend ActiveSupport::Concern

  included do
    has_many :events, :as => :triggerable
    after_create :log_create_event
    after_update :log_update_event
    after_destroy :log_destroy_event
  end

  def log_create_event
    Event.create!(event_type: 'create', user: author, triggerable: self)
  end

  def log_update_event
    Event.create!(event_type: 'update', user: author, triggerable: self)
  end

  def log_destroy_event
    Event.create!(event_type: 'destroy', user: author, triggerable: self)
  end
end

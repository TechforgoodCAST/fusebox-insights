module Triggerable
  extend ActiveSupport::Concern

  included do
    has_many :events, :as => :triggerable
    after_create :log_create_event
    before_update :log_update_event
    after_destroy :log_destroy_event
  end

  def log_create_event
    Event.create!(event_type: 'create', user: author, triggerable: self)

    # if there is a group, also create an 'add to group' log
    if self.group
      Event.create!(event_type: 'add_to_group', user: author, triggerable: self)
    end

  end

  def log_update_event
    Event.create!(event_type: 'update', user: author, triggerable: self)
    # if there was not a group previously, but now there is
    # it implies the object has been added to a group, so create an event log
    if !self.group_id_was && self.group_id
      Event.create!(event_type: 'add_to_group', user: author, triggerable: self)
    end
  end

  def log_destroy_event
    Event.create!(event_type: 'destroy', user: author, triggerable: self)
  end
end
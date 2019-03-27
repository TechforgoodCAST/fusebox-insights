# frozen_string_literal: true


class EventCallbacks
  def after_create(new_event)

    # get events of same type, related object and project
    @events_of_same_project_and_type = Event.where(
      project_id: new_event.triggerable.author.project_id,
      event_type: new_event.event_type,
      triggerable_type: new_event.triggerable_type,
    )

    # get relevant support messages that have also met the occurences
    # condition based on the previously existing matching event instances
    @support_messages = SupportMessage.where(
      project_id: new_event.project_id,
      status: 'Incomplete',
      rule_event_type: new_event.event_type,
      rule_object_type: new_event.triggerable_type,
    )
    .where(
      'rule_occurrences >= ?', @events_of_same_project_and_type.count,
    )
    
    # iterate over relevant messages and update status
    @support_messages.each do |message| 
      message.status = 'Complete'
      message.save
    end

  end
end


class Event < ApplicationRecord
  after_create EventCallbacks.new
  VALID_EVENT_TYPES = ["create","update","destroy"]

  belongs_to :triggerable, :polymorphic => true
  belongs_to :user  

  validates :event_type, :inclusion => { :in => VALID_EVENT_TYPES }
end
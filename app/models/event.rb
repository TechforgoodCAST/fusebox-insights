# frozen_string_literal: true


class EventCallbacks
  def after_create(new_event)
    if !new_event.triggerable.nil? && new_event.triggerable.project
      @related_project = new_event.triggerable.project
      # get events of same type, related object and project
      @events_of_same_project_and_type = Event.where(
        event_type: new_event.event_type,
        triggerable_type: new_event.triggerable_type,
      )
      @relevant_event_count = 0
      @events_of_same_project_and_type.each do |event|
        if !event.triggerable.nil?
          if event.triggerable.project && event.triggerable.project == @related_project
            @relevant_event_count += 1
          end
        end
      end

      # get relevant support messages that have also met the occurences
      # condition based on the previously existing matching event instances
      @support_messages = SupportMessage.where(
        project_id: @related_project.id,
        status: 'Incomplete',
        rule_event_type: new_event.event_type,
        rule_object_type: new_event.triggerable_type,
      )
      .where(
        'rule_occurrences <= ?', @relevant_event_count,
      )
      
      # iterate over relevant messages and update status
      @support_messages.each do |message| 
        message.status = 'Complete'
        message.save
      end
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
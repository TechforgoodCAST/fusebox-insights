# frozen_string_literal: true


class EventCallbacks
    def after_create(new_event)

        # get events of same type, related object and project
        @events_of_same_project_and_type = Event.where(
            project_id: new_event.project_id,
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
            rule_occurrences: >= @events_of_same_project_and_type.count,
        )
        #update status
        @support_messages.update_all(:status => 'Complete')
    end
end


class Event < ApplicationRecord
    VALID_EVENT_TYPES = ["create","read","update","delete"]

    belongs_to :triggerable, :polymorphic => true
    belongs_to :project  

    validates :event_type, :inclusion => { :in => VALID_EVENT_TYPES }
end
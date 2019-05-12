# frozen_string_literal: true

class EventCallbacks
    def after_create(new_event)
      if !new_event.triggerable.nil? && new_event.triggerable.project
        @related_project = new_event.triggerable.project

        # get events of same type, related object and project
        # use accounted_for to not count old event logs of the same type
        @events_of_same_project_and_type = Event.where(
          accounted_for: false,
          event_type: new_event.event_type,
          triggerable_type: new_event.triggerable_type
        )
        @relevant_event_count = 0
        @events_of_same_project_and_type.each do |event|
          unless event.triggerable.nil?
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
          rule_object_type: new_event.triggerable_type
        )

        # also check for the occurence count
        @support_messages_occurences_met = @support_messages.where('rule_occurrences <= ?', @relevant_event_count)

        if @support_messages_occurences_met.any?
          @support_messages_occurences_met.update_all(status: 'Complete')

          # set accounted_for so the event logs for this action are not
          # counted for in the future, flag is only set if there are relevant
          # support messages
          @events_of_same_project_and_type.update_all(accounted_for: true)

        end
      end
    end
  end

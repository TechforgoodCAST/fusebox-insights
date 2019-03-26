# frozen_string_literal: true

class Event < ApplicationRecord
    VALID_EVENT_TYPES = ["create","read","update","delete"]

    belongs_to :triggerable, :polymorphic => true
    belongs_to :project  

    validates :event_type, :inclusion => { :in => VALID_EVENT_TYPES }
end
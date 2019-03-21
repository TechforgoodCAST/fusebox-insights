# frozen_string_literal: true

VALID_EVENT_TYPES = ["create","read","update","delete"]

class Event < ApplicationRecord
    belongs_to :triggerable, :polymorphic => true

    validates :event_type, :inclusion => { :in => VALID_EVENT_TYPES }
end
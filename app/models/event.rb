# frozen_string_literal: true

class Event < ApplicationRecord
    VALID_EVENT_TYPES = ["create","update","destroy"]

    belongs_to :triggerable, :polymorphic => true
    belongs_to :user  

    validates :event_type, :inclusion => { :in => VALID_EVENT_TYPES }
end
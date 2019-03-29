# frozen_string_literal: true

class Event < ApplicationRecord
  after_create EventCallbacks.new
  VALID_EVENT_TYPES = ['create', 'update', 'destroy', 'add_to_group']

  belongs_to :triggerable, :polymorphic => true
  belongs_to :user  

  validates :event_type, :inclusion => { :in => VALID_EVENT_TYPES }
end
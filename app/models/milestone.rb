# frozen_string_literal: true

class Milestone < ApplicationRecord
  PRESETS = [
    {
      title: 'Discover',
      description: 'We know about the problem, the context within which it occurs and the value of solving it from the perspective of those affected.',
      deadline: 3.months.since,
      status: :committed
    },
    {
      title: 'Define',
      description: "We know how we’ll address the problem by meeting people's needs, expectations and behaviours. And how we’ll contribute to the resolution of a social issue and/or avoid negative consequences for people and planet.",
      deadline: 6.months.since,
      status: :planned
    },
    {
      title: 'Develop',
      description: 'We know how we’ll deliver, grow and sustain our solution.',
      deadline: 9.months.since,
      status: :planned
    }
  ].freeze

  belongs_to :project

  enum status: { planned: 0, committed: 1, completed: 2 }, _prefix: :status

  validates :deadline, :description, :status, :title, presence: true

  audited
end

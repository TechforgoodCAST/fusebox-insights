# frozen_string_literal: true

class Iteration < ApplicationRecord
  belongs_to :project

  has_many :check_ins, dependent: :destroy
  has_many :outcomes, inverse_of: :iteration, dependent: :destroy
  
  attr_accessor :committing

  accepts_nested_attributes_for :outcomes, reject_if: :all_blank, update_only: true, allow_destroy: true, limit: 5

  enum status: { draft: 0, committed: 100, completed: 200}, _prefix: :status

  validates :title, presence: true
  validates :description, :start_date, :debrief_date, presence: true, :if => :committing
  validates :outcomes, length: {minimum: 1, message: 'Should have at least 1 outcome defined.'}, :if => :committing
  validate :start_date_cannot_be_in_the_past
  validate :start_date_cannot_be_in_the_past
  
  def progress
    
    if status === 'committed'

      if end_date < Date.today
        progress = 'completed'
      end

      if start_date < Date.today && end_date > Date.today
        progress = 'in_progress'
      end

      if start_date > Date.today
        progress = 'planned'
      end
      
    else
      
      progress = status
      
    end    
    
    return progress
    
  end
  
  private
  
  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "Can't be in the past")
    end
  end
    
  def debrief_date_cannot_be_before_start_date
    if debrief_date.present? && debrief_date < start_date
      errors.add(:debrief_date, "Can't be before start date")
    end
  end
  
end

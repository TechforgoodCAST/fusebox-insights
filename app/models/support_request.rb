class SupportRequest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :on_behalf_of, class_name: 'User', optional: true
  belongs_to :offer
  belongs_to :project
  
  validates :requester, :message, presence: true
end

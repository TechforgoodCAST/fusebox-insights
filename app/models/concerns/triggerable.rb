module Triggerable
  extend ActiveSupport::Concern

  included do
    has_many :events, :as => :triggerable
  end
end
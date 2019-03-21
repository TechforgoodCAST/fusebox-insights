module Triggerable
  extend ActiveSupport::Concern

  included do
    has_one :events, :as => :triggerable
  end
end
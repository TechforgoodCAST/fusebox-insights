# frozen_string_literal: true

class FociController < ApplicationController
  before_action :authenticate_user!

  def index
    @foci = current_user.in_focus
  end
end

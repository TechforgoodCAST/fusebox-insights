# frozen_string_literal: true

class FociController < ApplicationController
  before_action :authenticate_user!

  def index
    @foci = current_user.in_focus
  end

  def update
    if current_user.update(form_params)
      redirect_to in_focus_path, notice: 'Focus successfully updated.'
    else
      render :edit
    end
  end

  private

    def form_params
      params.require(:user).permit(in_focus_ids: [])
    end
end

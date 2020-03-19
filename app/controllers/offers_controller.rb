# frozen_string_literal: true

class OffersController < ApplicationController
  before_action :authenticate_user!, :load_project

  def show
    @project = Project.find(params[:project_id])

    if @project.topics.empty?
      flash[:alert] = "Sorry, you don't have access to that"
      redirect_back(fallback_location: root_path)
    end

    @offer = Offer.find(params[:id])
  end
end

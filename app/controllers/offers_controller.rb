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

    previous_url = URI(request.referer || '').path
    if previous_url.include? "topic"
      session[:previous_url] = previous_url
    end
    @back_url = session[:previous_url]
  end
end

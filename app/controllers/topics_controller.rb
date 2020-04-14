# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :authenticate_user!, :load_project

  def index
    @topics = @project.topics.uniq.sort_by(&:title)

    return unless @topics.empty?

    flash[:alert] = "Sorry, you don't have access to that"
    redirect_back(fallback_location: root_path)
  end

  def show
    @topic = Topic.find(params[:id])
    @offers = @topic.offers & @project.offers

    return if @project.topics.include?(@topic)

    flash[:alert] = "Sorry, you don't have access to that"
    redirect_back(fallback_location: root_path)
  end
end

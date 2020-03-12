# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :authenticate_user!, :load_project

  def index
    @topics = @project.topics.sort_by{ |t| t.title }
    
    if @topics.empty?
      flash[:alert] = "Sorry, you don't have access to that"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @topic = Topic.find_by(id: params[:id])
  end
end

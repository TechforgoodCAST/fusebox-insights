# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :authenticate_user!, :load_project

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find_by(id: params[:id])
  end
end

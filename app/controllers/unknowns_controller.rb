# frozen_string_literal: true

class UnknownsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_unknown, only: %i[show edit update destroy]
  before_action :projects_for_unknown, only: %i[new create edit update]

  def index
    # TODO: spec
    @unknowns = Unknown.order(updated_at: :desc).page(params[:page])
  end

  def show
    confidence = {
      'none' => 0, 'more' => 1, 'less' => -1
    }[params[:confidence]]

    @response = Response.new(author: current_user, confidence: confidence)
  end

  def new
    @unknown = current_user.unknowns.new
    @initially_selected_project = @projects_for_unknown.first
  end

  def create
    @unknown = current_user.unknowns.new(unknown_params)
    
    if @unknown.save
      redirect_to @unknown, notice: 'Unknown was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @unknown
    @initially_selected_project = @unknown.project
  end

  def update
    authorize @unknown
    if @unknown.update(unknown_params)
      redirect_to @unknown, notice: 'Unknown was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @unknown
    @unknown.destroy
    redirect_to unknowns_url, notice: 'Unknown was successfully destroyed.'
  end

  private

    def set_unknown
      @unknown = Unknown.find(params[:id])
    end

    def projects_for_unknown
      @owned_projects = Project.where(user: current_user)
      @member_projects = Project.joins(:project_members).where(user: current_user)
      @projects_for_unknown = @owned_projects + @member_projects
    end

    def unknown_params
      params.require(:unknown).permit(:title, :description, :group_id, :project_id)
    end
    
end

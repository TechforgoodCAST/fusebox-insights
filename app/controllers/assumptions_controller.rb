# frozen_string_literal: true

class AssumptionsController < ApplicationController

  before_action :authenticate_user!, except: %i[show]
  before_action :set_assumption, only: %i[show edit update destroy]
  before_action :set_project
  before_action :projects_for_assumption, only: %i[new create edit update]

  def index
    @assumptions = Assumption.order(updated_at: :desc).page(params[:page])
  end

  def show
    authorize @assumption
    confidence = {
      'none' => 0, 'more' => 1, 'less' => -1
    }[params[:confidence]]

    @response = Response.new(author: current_user, confidence: confidence)
  end

  def new
    @assumption = current_user.assumptions.new
  end

  def create
    @assumption = current_user.assumptions.new(assumption_params)
    @assumption.project = @project

    if @assumption.save
      redirect_to project_assumption_path(@project, @assumption), notice: 'Assumption was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @assumption
  end

  def update
    authorize @assumption
    if @assumption.update(assumption_params)
      redirect_to project_assumption_path(@project, @assumption), notice: 'Assumption was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @assumption
    @assumption.destroy
    redirect_to project_path(@project), notice: 'Assumption was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  def set_assumption
    @assumption = Assumption.find(params[:id])
  end

  def projects_for_assumption
    @owned_projects = Project.where(author: current_user)
    @member_projects = Project.joins(:project_members).where(author: current_user)
    @projects_for_assumption = @owned_projects + @member_projects
  end

  def assumption_params
    params.require(:assumption).permit(:title, :description, :group_id, :project_id, :certainty)
  end
end

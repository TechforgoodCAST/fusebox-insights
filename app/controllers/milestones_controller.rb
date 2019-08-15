# frozen_string_literal: true

class MilestonesController < ApplicationController
  before_action :authenticate_user!, :load_project

  def show
    @milestone = authorize @project.milestones.find_by(id: params[:id])
  end

  def new
    @milestone = authorize @project.milestones.new
  end

  def create
    @milestone = authorize @project.milestones.new(milestone_params)

    if @milestone.save
      update_milestone_statues!(@project)
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
    @milestone = authorize @project.milestones.find_by(id: params[:id])
  end

  def update
    @milestone = authorize @project.milestones.find_by(id: params[:id])

    if @milestone.update(milestone_params)
      update_milestone_statues!(@project)
      redirect_to project_milestone_url(@project, @milestone)
    else
      render :edit
    end
  end

  private

  def milestone_params
    params.require(:milestone).permit(
      :deadline, :description, :success_criteria, :title
    )
  end

  def update_milestone_statues!(project)
    incomplete = project.milestones.where.not(status: :complete)
                        .order(:deadline, :title)
    incomplete.update_all(status: :planned)
    incomplete.first.update(status: :in_progress)
  end
end

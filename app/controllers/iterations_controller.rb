# frozen_string_literal: true

class IterationsController < ApplicationController
  before_action :load_project

  def index
    redirect_to project_url(@project)
  end

  def new
    @iteration = authorize @project.iterations.new
  end

  def create
    @iteration = authorize @project.iterations.new(iteration_params)

    if @iteration.save
      redirect_to project_iteration_url(@project, @iteration), notice: msg(@iteration.draftable?)
    else
      render :new
    end
  end

  def show
    @iteration = authorize @project.iterations.find(params[:id])
  end

  def edit
    @iteration = authorize @project.iterations.find(params[:id])
  end

  def update
    @iteration = authorize @project.iterations.find(params[:id])

    if @iteration.update(iteration_params)
      redirect_to project_iteration_url(@project, @iteration), notice: msg(@iteration.draftable?)
    else
      render :edit
    end
  end

  def destroy
    @iteration = authorize Iteration.find(params[:id])
    @iteration.destroy

    @project = Project.find(params[:project_id])
    redirect_to project_path(@project), notice: 'Draft iteration deleted.'
  end

  private

  def iteration_params
    params.require(:iteration).permit(
      :title, :description, :start_date, :planned_debrief_date, :status,
      outcomes_attributes: %i[id title success_criteria _destroy]
    )
  end

  def msg(draftable)
    {
      true => 'Iteration saved as draft.',
      false => "Iteration saved. You'll receive reminders to " \
               'check-in every two weeks from the start date.'
    }[draftable]
  end
end

# frozen_string_literal: true

class IterationsController < ApplicationController
  def new
    @project = authorize Project.find(params[:project_id])
    @iteration = Iteration.new
    @iteration.start_date = Date.today
    @iteration.outcomes.build
  end

  def create
    @project = authorize Project.find(params[:project_id])
    
    if params[:commit]
      draft = false;
      status = 100
    else
      draft = true;
      status = 0
    end
      
    @iteration = @project.iterations.create(iteration_params.merge({:committing => !draft, :status => status}))

    if @iteration.save
      redirect_to project_iteration_url(@project, @iteration)
    else
      render 'new'
    end
  end

  def show
    @project = authorize Project.find(params[:project_id])
    @iteration = authorize Iteration.find(params[:id])
  end

  def edit
    @project = authorize Project.find(params[:project_id])
    @iteration = authorize Iteration.find(params[:id])

    @iteration.outcomes.build
  end

  def update
    @project = authorize Project.find(params[:project_id])
    @iteration = authorize Iteration.find(params[:id])

    if @iteration.update(iteration_params)
      redirect_to project_iteration_url(@project, @iteration)
    else
      render 'edit'
    end
  end

  def destroy
    @project = authorize Project.find(params[:project_id])
    @iteration = authorize Iteration.find(params[:id])
    @iteration.destroy

    redirect_to project_path(@project)
  end

  private

  def iteration_params
    params.require(:iteration).permit(
      :title, :description, :start_date, :debrief_date, :status,
      outcomes_attributes: %i[id title description]
    )
  end
end

class IterationsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @iteration = @project.iterations.create(iteration_params)
    redirect_to project_path(@project)
  end

  def new
    @project = Project.find(params[:project_id])
    @iteration = Iteration.new

    3.times { @iteration.outcomes.build }
  end

  def show
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:id])
  end

  def edit
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:id])

    if @iteration.update(iteration_params)
      redirect_to project_iteration_url(@project, @iteration)
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:id])
    @iteration.destroy

    redirect_to project_path(@project)
  end

  private
    def iteration_params
      params.require(:iteration).permit(:title, :description, :start_date, :end_date, outcomes_attributes: [:id, :title, :description ])
    end
end

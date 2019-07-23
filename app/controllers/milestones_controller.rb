class MilestonesController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @milestone = @project.milestones.create(milestone_params)
    redirect_to project_path(@project)
  end

  def new
    @project = Project.find(params[:project_id])
    @milestone = Milestone.new
  end

  def edit
    @project = Project.find(params[:project_id])
    @milestone = Milestone.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @milestone = Milestone.find(params[:id])

    if @milestone.update(milestone_params)
      redirect_to project_milestone_url(@project, @milestone)
    else
      render 'edit'
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @milestone = Milestone.find(params[:id])
  end

  private

  def milestone_params
    params.require(:milestone).permit(:title, :description, :date, :completed)
  end
end

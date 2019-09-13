# frozen_string_literal: true

class DebriefsController < ApplicationController
  def index
    new
  end

  def new
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    @milestone = @project.milestones.find_by(status: :planned)

    if Debrief.find_by(iteration: @iteration)
      flash[:alert] = "You've already debriefed this iteration"
      redirect_to project_iteration_url(@project, @iteration)
    end

    @debrief = authorize @iteration.build_debrief

    @iteration.outcomes.length.times { @debrief.debrief_ratings.build }
  end

  def create
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    @milestone = @project.milestones.find_by(status: :planned)
    @debrief = authorize @iteration.create_debrief(debrief_params)
    if @debrief.save
      NotificationsMailer.debrief_complete(@debrief, current_user).deliver_now
      @iteration.update(status: 'completed')
      @milestone.update(status: 'completed') if debrief_params[:milestone_completed]
      redirect_to project_iteration_url(@project, @iteration)
    else
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    @debrief = authorize Debrief.find(params[:id])
    @milestone = @debrief.milestone
  end

  private

  def debrief_params
    params
      .require(:debrief)
      .permit(:notes, :milestone_id, :milestone_completed, debrief_ratings_attributes: %i[id score comments iteration outcome_id])
      .with_defaults(completed_by: current_user.id)
  end
end

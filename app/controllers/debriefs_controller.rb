# frozen_string_literal: true

class DebriefsController < ApplicationController
  def index
    new
  end

  def new
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    @milestone = @project.milestones.find_by(status: :planned)
    @debrief = authorize @iteration.debriefs.new

    (@iteration.outcomes.length).times { @debrief.debrief_ratings.build }
  end

  def create
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    @milestone = @project.milestones.find_by(status: :planned)
    @debrief = authorize @iteration.debriefs.create(debrief_params)
    if @debrief.save
      NotificationsMailer.debrief_complete(@debrief, current_user).deliver_now
      @iteration.update({status: 'completed'})
      @milestone.update({status: 'completed'}) if params[:debrief][:milestone_completed]
      redirect_to project_iteration_url(@project, @iteration)
    else
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    @debrief = authorize Debrief.find(params[:id])
  end

  private

  def debrief_params
    params
    .require(:debrief)
    .permit(:notes, :milestone_completed, debrief_ratings_attributes: [:id, :score, :comments, :iteration, :outcome_id ])
    .with_defaults(completed_by: current_user.id, complete_at: DateTime.now)
  end
end

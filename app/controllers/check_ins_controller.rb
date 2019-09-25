# frozen_string_literal: true

class CheckInsController < ApplicationController
  def index
    new
  end

  def new
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    @check_in = authorize @iteration.check_ins.new

    @iteration.outcomes.length.times { @check_in.ratings.build }
  end

  def create
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])

    @check_in = authorize @iteration.check_ins.create(check_in_params)

    if @check_in.save
      NotificationsMailer.check_in_complete(@check_in, current_user).deliver_now
      @iteration.update!(last_check_in_at: Time.current)
      redirect_to project_iteration_url(@project, @iteration)
    else
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    @check_in = authorize CheckIn.find(params[:id])
  end

  private

  def check_in_params
    params
      .require(:check_in)
      .permit(:notes, ratings_attributes: %i[id score comments iteration outcome_id])
      .with_defaults(completed_by: current_user.id)
  end
end

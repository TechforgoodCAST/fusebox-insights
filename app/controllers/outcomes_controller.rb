# frozen_string_literal: true

class OutcomesController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    @outcome = Outcome.find(params[:id])
  end

  def destroy
    @iteration = Iteration.find(params[:iteration_id])
    @outcome = Outcome.find(params[:id])
    @outcome.destroy

    redirect_to iteration_path(@iteration)
  end
end

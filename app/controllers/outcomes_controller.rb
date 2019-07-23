class OutcomesController < ApplicationController

  def show
    @programme = Programme.find(params[:programme_id])
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

class IterationsController < ApplicationController
  
  def create
    @programme = Programme.find(params[:programme_id])
    @iteration = @programme.iterations.create(iteration_params)
    redirect_to programme_path(@programme)
  end
  
  def new
    @programme = Programme.find(params[:programme_id])
    @iteration = Iteration.new
    
    3.times { @iteration.outcomes.build }
  end
  
  def show
    @programme = Programme.find(params[:programme_id])
    @iteration = Iteration.find(params[:id])
  end
  
  def edit
    @programme = Programme.find(params[:programme_id])
    @iteration = Iteration.find(params[:id])
  end
  
  def update
    @programme = Programme.find(params[:programme_id])
    @iteration = Iteration.find(params[:id])

    if @iteration.update(iteration_params)
      redirect_to programme_iteration_url(@programme, @iteration)
    else
      render 'edit'
    end
  end
  
  def destroy
    @programme = Programme.find(params[:programme_id])
    @iteration = Iteration.find(params[:id])
    @iteration.destroy

    redirect_to programme_path(@programme)
  end
 
  private
    def iteration_params
      params.require(:iteration).permit(:title, :description, :start_date, :end_date, outcomes_attributes: [:id, :title, :description ])
    end
end

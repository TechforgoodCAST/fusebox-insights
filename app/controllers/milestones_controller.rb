class MilestonesController < ApplicationController

  def create
    @programme = Programme.find(params[:programme_id])
    @milestone = @programme.milestones.create(milestone_params)
    redirect_to programme_path(@programme)
  end
  
  def new
    @programme = Programme.find(params[:programme_id])
    @milestone = Milestone.new
  end
  
  
  
  def edit
    @programme = Programme.find(params[:programme_id])
    @milestone = Milestone.find(params[:id])
  end
  
  def update
    @programme = Programme.find(params[:programme_id])
    @milestone = Milestone.find(params[:id])

    if @milestone.update(milestone_params)
      redirect_to programme_milestone_url(@programme, @milestone)
    else
      render 'edit'
    end
  end
  
  def show
    @programme = Programme.find(params[:programme_id])
    @milestone = Milestone.find(params[:id])
  end
 
  private
    def milestone_params
      params.require(:milestone).permit(:title, :description, :date, :completed)
    end
end

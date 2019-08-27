class CheckInsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    @check_in = CheckIn.new
    
    (@iteration.outcomes.length).times { @check_in.ratings.build }
  end
  
  def create
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    
    @check_in = @iteration.check_ins.create(check_in_params)
    
    if @check_in.save
      redirect_to project_iteration_url(@project, @iteration)
    else
      render 'new'
    end
  end
  
  def show
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    @check_in = CheckIn.find(params[:id])
  end
  
  private
    def check_in_params
      params.require(:check_in).permit(:notes, :completed, ratings_attributes: [:id, :score, :comments, :iteration, :outcome_id ])
    end
end

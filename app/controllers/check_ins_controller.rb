class CheckInsController < ApplicationController
  
  def index
    new
  end
  
  def new
    @project = authorize Project.find(params[:project_id])
    @iteration = authorize Iteration.find(params[:iteration_id])
    @check_in = authorize @iteration.check_ins.new
    
    (@iteration.outcomes.length).times { @check_in.ratings.build }
  end
  
  def create
    @project = authorize Project.find(params[:project_id])
    @iteration = authorize Iteration.find(params[:iteration_id])
    
    @check_in = @iteration.check_ins.create(check_in_params)
    
    if @check_in.save
      redirect_to project_iteration_url(@project, @iteration)
    else
      render 'new'
    end
  end
  
  def show
    @project = authorize Project.find(params[:project_id])
    @iteration = authorize Iteration.find(params[:iteration_id])
    @check_in = authorize CheckIn.find(params[:id])
  end
  
  private
    def check_in_params
      params
      .require(:check_in)
      .permit(:notes, ratings_attributes: [:id, :score, :comments, :iteration, :outcome_id ])
      .with_defaults(completed_by: current_user.id, complete_at: Date.current())
    end
end

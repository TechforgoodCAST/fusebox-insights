class CheckInsController < ApplicationController
  
  def index
    new
  end
  
  def new
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    @check_in = authorize @iteration.check_ins.new
    
    (@iteration.outcomes.length).times { @check_in.ratings.build }
  end
  
  def create
    @project = Project.find(params[:project_id])
    @iteration = Iteration.find(params[:iteration_id])
    
    @check_in = authorize @iteration.check_ins.create(check_in_params)
    
    if @check_in.save
      check_in_complete
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
      .permit(:notes, ratings_attributes: [:id, :score, :comments, :iteration, :outcome_id ])
      .with_defaults(completed_by: current_user.id, complete_at: Date.current())
    end
  
    def check_in_complete
      memberships = Membership.joins(:user).where(project: @project).select(
        'memberships.*', 'users.full_name AS user_full_name', 'users.email AS user_email'
      )
      @contributors_and_mentors = memberships.select { |m| m.role == 'contributor' || m.role == 'mentor' }

      @contributors_and_mentors.each{ |membership|
        NotificationsMailer.check_in_complete(@check_in, current_user, membership.user).deliver_now
      }
    end
end

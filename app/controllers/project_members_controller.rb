
class ProjectMembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project_member
  before_action :set_project

  def index
    @members = ProjectMember.find_by(project: @project)
  end
  
  def new

    if !is_user_project_creator
      redirect_to projects_path, notice: 'You do not have perission to add members to this project.'
    end
    
    @project_member = ProjectMember.new
    @ids = ProjectMember.where(project: @project).pluck(:user_id)

    @ids.push(@project.user.id)
    @potential_members = User.where.not(id: @ids)
  end
  
  def create
    if !is_user_project_creator
      redirect_to projects_path, notice: 'You do not have perission to add members to this project.'
    end
    @current_project = Project.find_by(slug: params[:slug])
    @selected_user = User.find_by(id: project_member_params[:user])
    @project_member = ProjectMember.new(user: @selected_user, project: @current_project)
    if @project_member.save
      redirect_to projects_path, notice: 'Member added successfully.'
    else
      render :new
    end
  end
  
  def destroy
    @project_member.destroy
    redirect_to projects_path, notice: 'Member removed successfully.'
  end

  private

    def set_project_member
      @project_member = ProjectMember.find_by(id: params[:id])
    end

    def set_project
      @project = Project.find_by(slug: params[:slug])
    end

    def is_user_project_creator
      @project.user == current_user
    end

    def project_member_params
      params.require(:project_member).permit(:user, :project)
    end
  
end
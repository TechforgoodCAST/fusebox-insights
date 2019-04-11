# frozen_string_literal: true

class ProjectMembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project_member
  before_action :set_project

  def index
    @members = ProjectMember.find_by(project: @project)
  end

  def new
    @project_member = ProjectMember.new(project: @project)
    authorize @project_member

    @ids = ProjectMember.where(project: @project).pluck(:user_id)

    @ids.push(@project.user.id)
    @potential_members = User.where.not(id: @ids)
  end

  def create
    @current_project = Project.find_by(slug: params[:slug])
    @selected_user = User.find_by(id: project_member_params[:user])

    @project_member = ProjectMember.new(user: @selected_user, project: @current_project, role: project_member_params[:role])
    authorize @project_member

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

  def project_member_params
    params.require(:project_member).permit(:user, :project, :role)
  end
end

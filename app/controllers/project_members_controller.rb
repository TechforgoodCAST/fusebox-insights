# frozen_string_literal: true

class ProjectMembersController < ApplicationController
  before_action :authenticate_user!, :load_project, :load_project_member

  def index
    @members = ProjectMember.find_by(project: @project)
  end

  def new
    @project_member = @project.project_members.new
    authorize @project_member

    @ids = ProjectMember.where(project: @project).pluck(:user_id)

    @ids.push(@project.author.id)
    @potential_members = User.where.not(id: @ids)
  end

  def create
    @selected_user = User.find_by(id: project_member_params[:user])

    @project_member = @project.project_members.new(user: @selected_user, role: project_member_params[:role])
    authorize @project_member

    if @project_member.save
      redirect_to project_path(@project), notice: 'Member added successfully.'
    else
      render :new
    end
  end

  def destroy
    @project_member.destroy
    redirect_to project_path(@project), notice: 'Member removed successfully.'
  end

  private

  def load_project_member
    @project_member = ProjectMember.find_by(id: params[:id])
  end

  def project_member_params
    params.require(:project_member).permit(:user, :project, :role)
  end
end

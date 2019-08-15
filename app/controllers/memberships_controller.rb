# frozen_string_literal: true

class MembershipsController < ApplicationController
  before_action :authenticate_user!, :authorise_user

  def show
    @project = Project.find(params[:id])
    memberships = Membership.joins(:user).where(project: 3).select(
      'memberships.*', 'users.full_name AS user_full_name', 'users.email AS user_email'
    )
    @contributors = memberships.select { |m| m.role == 'contributor' }
    @stakeholders = memberships.select { |m| m.role == 'stakeholder' }
    @mentors = memberships.select { |m| m.role == 'mentor' }
  end

  def index
    @project = Project.find_by(id: params[:project_id])
    redirect_to share_project_path(@project)
  end

  def new
    @project = Project.find_by(id: params[:project_id])
    @membership = @project.memberships.new(role: params[:role] || 'contributor')
  end

  def create
    @project = Project.find_by(id: params[:project_id])
    @membership = @project.memberships.new(membership_params)

    if @membership.save_with_user
      NotificationsMailer.project_invite(@membership).deliver_now
      redirect_to share_project_path(@project), notice: "#{@membership.role.titleize} added"
    else
      render :new
    end
  end

  def destroy
    @project = Project.find_by(id: params[:project_id])
    @membership = Membership.find_by(id: params[:id])
    notice = "#{@membership.role.titleize} removed"
    @membership.destroy
    redirect_to share_project_path(@project), notice: notice
  end

  private

  def authorise_user
    project_id = params[:project_id].presence || params[:id]
    membership = Membership.find_by(project_id: project_id, user: current_user)
    authorize membership, policy_class: MembershipPolicy
  end

  def membership_params
    params.require(:membership).permit(:email, :full_name, :role)
  end
end

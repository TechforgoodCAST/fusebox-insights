# frozen_string_literal: true

class MembershipsController < ApplicationController
  before_action :authenticate_user!, :load_project, :authorise_user

  def index
    redirect_to share_project_path(@project)
  end

  def show
    memberships = Membership.joins(:user).where(project: @project).select(
      'memberships.*', 'users.full_name AS user_full_name', 'users.email AS user_email'
    )
    @contributors = memberships.select { |m| m.role == 'contributor' }
    @stakeholders = memberships.select { |m| m.role == 'stakeholder' }
    @mentors = memberships.select { |m| m.role == 'mentor' }
  end

  def new
    @membership = @project.memberships.new(role: params[:role] || 'contributor')
  end

  def create
    @membership = @project.memberships.new(membership_params)

    if @membership.save_with_user
      NotificationsMailer.project_invite(@membership).deliver_now
      redirect_to share_project_path(@project), notice: "#{@membership.role.titleize} added"
    else
      render :new
    end
  end

  def destroy
    @membership = Membership.find_by(id: params[:id])
    notice = "#{@membership.role.titleize} removed"
    removing_current_user = @membership.user == current_user
    @membership.destroy
    if removing_current_user
      redirect_to projects_path, notice: 'You have been removed from the project'
    else
      redirect_to share_project_path(@project), notice: notice
    end
  end

  private

  def authorise_user
    membership = Membership.find_by(project: @project, user: current_user)
    authorize membership, policy_class: MembershipPolicy
  end

  def membership_params
    params.require(:membership).permit(:email, :full_name, :role)
  end
end

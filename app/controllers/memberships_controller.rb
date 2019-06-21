# frozen_string_literal: true

class MembershipsController < ApplicationController
  before_action :authenticate_user!, :load_project, :load_membership

  def index
    @members = Membership.find_by(project: @project)
  end

  def new
    @membership = @project.memberships.new
    authorize @membership

    @ids = Membership.where(project: @project).pluck(:user_id)

    @ids.push(@project.author.id)
    @potential_members = User.where.not(id: @ids)
  end

  def create
    @selected_user = User.find_by(id: membership_params[:user])

    @membership = @project.memberships.new(user: @selected_user, role: membership_params[:role])
    authorize @membership

    if @membership.save
      redirect_to project_path(@project), notice: 'Member added successfully.'
    else
      render :new
    end
  end

  def destroy
    @membership.destroy
    redirect_to project_path(@project), notice: 'Member removed successfully.'
  end

  private

  def load_membership
    @membership = Membership.find_by(id: params[:id])
  end

  def membership_params
    params.require(:membership).permit(:user, :project, :role)
  end
end

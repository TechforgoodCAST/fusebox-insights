# frozen_string_literal: true

class SupportRequestsController < ApplicationController
  before_action :authenticate_user!, :load_project

  def new
    @project = Project.find(params[:project_id])

    if @project.topics.empty? || current_user.is_project_member?(@project, 'stakeholder')
      flash[:alert] = "Sorry, you don't have access to that"
      redirect_back(fallback_location: root_path)
    end

    @offer = Offer.find(params[:offer_id])
    @request = @offer.support_requests.new
  end

  def create
    @project = Project.find(params[:project_id])
    @offer = Offer.find(params[:offer_id])

    @request = authorize @offer.support_requests.create(support_request_params)

    if @request.save
      NotificationsMailer.support_requested(@request, current_user).deliver_now
      redirect_to project_url(@project)
      flash[:notice] = 'Support request sent! You should hear back soon.'
    else
      render 'new'
    end
  end

  private

  def support_request_params
    params
      .require(:support_request)
      .permit(:message, :on_behalf_of_id)
      .with_defaults(requester: current_user, project: Project.find(params[:project_id]))
  end
end

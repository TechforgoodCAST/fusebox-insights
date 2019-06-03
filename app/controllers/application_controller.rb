# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :current_password) }
  end

  private

  def load_project
    @project = Project.friendly.find(params[:project_id].presence || params[:id])
  end

  def user_not_authorized
    flash[:alert] = "Sorry, you don't have access to that"
    redirect_back(fallback_location: root_path)
  end
end

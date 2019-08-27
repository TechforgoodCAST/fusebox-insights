# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :track_action

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:full_name, :email, :password)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:full_name, :display_name, :email, :password, :current_password)
    end
  end

  def track_action
    ahoy.track "#{controller_name}##{action_name}", request.path_parameters
  end

  private

  def load_project
    @project = Project.find_by(id: params[:project_id].presence || params[:id])
  end

  def user_not_authorized
    flash[:alert] = "Sorry, you don't have access to that"
    redirect_back(fallback_location: root_path)
  end
end

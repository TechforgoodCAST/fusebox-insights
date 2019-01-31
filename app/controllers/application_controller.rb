class ApplicationController < ActionController::Base
    include Pundit
    protect_from_forgery

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

        def user_not_authorized
            flash[:alert] = "Sorry, you don't have access to that"
            redirect_back(fallback_location: root_path)
        end
end

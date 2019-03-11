# frozen_string_literal: true

class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def create
    @response = Response.new(response_params)
    @unknown = Unknown.find_by(id: params[:id])

    @response.author = current_user
    @response.unknown = @unknown

    if @response.save
      redirect_to unknown_path(@unknown), notice: 'Response successfully added.'
    else
      render 'unknowns/show'
    end
  end

  private

    def response_params
      params.require(:response).permit(:confidence, :description, :title, :type)
    end
end

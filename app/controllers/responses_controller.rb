# frozen_string_literal: true

class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def create
    @response = Response.new(response_params)
    @assumption = Assumption.find_by(id: params[:assumption_id])
    @project = @assumption.project

    @response.author = current_user
    @response.assumption = @assumption

    if @response.save
      redirect_to project_assumption_path(@assumption.project, @assumption), notice: 'Response successfully added.'
    else
      render 'assumptions/show'
    end
  end

  private

  def response_params
    params.require(:response).permit(:confidence, :description, :title, :type)
  end
end

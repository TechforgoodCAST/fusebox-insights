# frozen_string_literal: true

class ReflectionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @reflection = Reflection.new(author: current_user)
  end

  def create
    @reflection = Reflection.new(form_params)
    @reflection.author = current_user

    if @reflection.save
      redirect_to in_focus_path, notice: 'Reflections successfully added.'
    else
      render :new
    end
  end

  private

    # TODO: Unpermitted parameters: :utf8, :authenticity_token, :commit
    def form_params
      params.permit(comments: %i[confidence title unknown_id])
    end
end

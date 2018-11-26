# frozen_string_literal: true

class UnknownsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_unknown, only: %i[show edit update destroy]

  def index
    @unknowns = Unknown.all
  end

  def new
    @unknown = current_user.authored.new
  end

  def create
    @unknown = current_user.authored.new(unknown_params)

    if @unknown.save
      redirect_to @unknown, notice: 'Unknown was successfully created.'
    else
      render :new
    end
  end

  def update
    if @unknown.update(unknown_params)
      redirect_to @unknown, notice: 'Unknown was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @unknown.destroy
    redirect_to unknowns_url, notice: 'Unknown was successfully destroyed.'
  end

  private

    def set_unknown
      @unknown = Unknown.find(params[:id])
    end

    def unknown_params
      params.require(:unknown).permit(:title, :description)
    end
end

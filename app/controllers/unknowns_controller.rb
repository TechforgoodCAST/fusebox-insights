# frozen_string_literal: true

class UnknownsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_responses, only: %i[show]
  before_action :set_unknown, only: %i[show edit update destroy]

  def index
    # TODO: spec
    @unknowns = Unknown.order(updated_at: :desc).page(params[:page])
  end

  def show
    confidence = {
      'none' => 0, 'more' => 1, 'less' => -1
    }[params[:confidence]]

    @response = Response.new(author: current_user, confidence: confidence)
  end

  def new
    @unknown = current_user.unknowns.new
  end

  def create
    @unknown = current_user.unknowns.new(unknown_params)

    if @unknown.save
      redirect_to @unknown, notice: 'Unknown was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @unknown
  end

  def update
    authorize @unknown
    if @unknown.update(unknown_params)
      redirect_to @unknown, notice: 'Unknown was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @unknown
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

    def get_responses
      unknown = Unknown.find(params[:id])
      @total_responses = (unknown.comments + unknown.proofs).sort{|a,b| a.updated_at <=> b.updated_at }
    end
    
end

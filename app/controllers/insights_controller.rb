# frozen_string_literal: true

class InsightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_insight, only: %i[show edit update destroy]

  def index
    # TODO: spec
    @insights = Insight.order(updated_at: :desc).page(params[:page])
  end

  def new
    @insight = current_user.insights.new
  end

  def create
    @insight = current_user.insights.new(insight_params)

    if @insight.save
      redirect_to @insight, notice: 'Insight was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @insight
  end

  def update
    authorize @insight
    if @insight.update(insight_params)
      redirect_to @insight, notice: 'Insight was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @insight
    @insight.destroy
    redirect_to insights_url, notice: 'Insight was successfully destroyed.'
  end

  private

    def set_insight
      @insight = Insight.find(params[:id])
    end

    def insight_params
      params.require(:insight).permit(:title, :description)
    end
end

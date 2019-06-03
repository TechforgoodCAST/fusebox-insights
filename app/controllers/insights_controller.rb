# frozen_string_literal: true

class InsightsController < ApplicationController
  before_action :authenticate_user!, :load_project
  before_action :load_insight, except: %i[index new]

  def index
    @insights = @project.insights.page(params[:page])
  end

  def new
    @insight = current_user.insights.new
  end

  def create
    @insight = current_user.insights.new(insight_params)

    if @insight.save
      redirect_to [@project, @insight], notice: 'Insight was successfully created.'
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
      redirect_to [@project, @insight], notice: 'Insight was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @insight
    @insight.destroy
    redirect_to project_insights_path(@project), notice: 'Insight deleted.'
  end

  private

  def insight_params
    params.require(:insight).permit(:title, :description)
  end

  def load_insight
    @insight = Insight.find(params[:id])
  end
end

# frozen_string_literal: true

class AssumptionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_project
  before_action :load_assumption, except: %i[index new create]

  def index
    authorize @project, policy_class: AssumptionPolicy
    @assumptions = @project.assumptions.order(created_at: :desc).page(params[:page])
  end

  def show
    authorize @assumption
    confidence = {
      'none' => 0, 'more' => 1, 'less' => -1
    }[params[:confidence]]

    @response = Response.new(author: current_user, confidence: confidence)
  end

  def new
    @group = Group.find_by(id: params[:group]) if params[:group].present?
    @assumption = current_user.assumptions.new(
      group: @group,
      certainty: params[:certainty]&.to_param
    )
  end

  def create
    @assumption = current_user.assumptions.new(assumption_params)
    @assumption.project = @project

    if @assumption.save
      redirect_to project_path(@project), notice: 'Card was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @assumption
  end

  def update
    authorize @assumption
    if @assumption.update(assumption_params)
      redirect_to project_path(@project), notice: 'Card was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @assumption
    @assumption.destroy
    redirect_to project_path(@project), notice: 'Card archived.'
  end

  # TODO: remove?
  def focus
    current_user.in_focus << @assumption unless current_user.in_focus.include?(@assumption)
    redirect_to foci_path
  end

  # TODO: remove?
  def unfocus
    current_user.in_focus.delete(@assumption)
    redirect_to project_assumption_path(@assumption.project, @assumption)
  end

  private

  def assumption_params
    params.require(:assumption).permit(:title, :description, :group_id, :project_id, :certainty, :damage)
  end

  def load_assumption
    @assumption = Assumption.includes(:group).find(params[:assumption_id].presence || params[:id])
  end
end

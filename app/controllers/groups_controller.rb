# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy]
  before_action :set_project

  def index
    @groups = Group.order(updated_at: :desc).page(params[:page])
  end

  def show; end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)

    @group.project_id = @project.id

    if @group.save
      redirect_to project_group_path(@project, @group), notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @group
  end

  def update
    authorize @group
    if @group.update(group_params)
      redirect_to project_group_path(@project, @group), notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @group
    @group.destroy
    redirect_to @project, notice: 'Group was successfully destroyed.'
  end

  def detach
    group = Group.find(params[:id])
    unknown = Unknown.find(params[:unknown_id])
    group.unknowns.delete(unknown)
    redirect_to project_group_path(@project, group),  notice: 'Assumption was successfully removed.'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def set_project
    @project = Project.find_by(slug: params[:project_slug])
  end

  def group_params
    params.require(:group).permit(:title, :description, :summary, :slug)
  end
end

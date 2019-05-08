# frozen_string_literal: true

class GroupsController < ApplicationController

  before_action :authenticate_user!, except: %i[show]
  before_action :set_group, only: %i[show edit update destroy]
  before_action :set_project

  def show

    authorize @group

  end

  def new
    @group = current_user.groups.new
    @group.project_id = @project.id
    authorize @group
  end

  def create
    @group = current_user.groups.new(group_params)
    @group.project_id = @project.id

    authorize @group

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

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  def group_params
    params.require(:group).permit(:title, :description, :summary, :slug)
  end
end

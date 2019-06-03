# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: %i[show assumptions]
  before_action :set_project, except: %i[index new create]

  def index
    @projects = current_user.projects.order(updated_at: :desc)
  end

  # TODO: refactor
  def assumptions
    authorize @project
    @assumptions = @project.assumptions.page(params[:page])
  end

  def show
    authorize @project
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)
    @project.users = [current_user]
    @project.author = current_user

    if @project.save
      redirect_to projects_path, notice: 'Project created successfully.'
    else
      render :new
    end
  end

  def edit
    authorize @project
  end

  def update
    authorize @project
    if @project.update(project_params)
      redirect_to projects_path, notice: 'Project updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    authorize @project
    @project.destroy
    redirect_to projects_path, notice: 'Project destroyed successfully.'
  end

  private

  def set_project
    pid = params[:project_id].presence || params[:id]
    @project = Project.friendly.find(pid)
  end

  def project_params
    params.require(:project).permit(:name, :description, :is_private)
  end
end

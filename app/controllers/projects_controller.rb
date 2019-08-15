# frozen_string_literal: true

# TODO: authorisation
class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to about_project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    redirect_to projects_path
  end

  def about
    @project = Project.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:description, :more_details, :title)
  end
end

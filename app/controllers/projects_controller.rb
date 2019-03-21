
class ProjectsController < ApplicationController
  before_action :authenticate_user!, :except => :show

  def index
    @projects = current_user.projects
  end
  
  def show
    @project = Project.find_by(slug: params[:id])
  end
  
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.generate_slug
    
    if @project.save
      redirect_to projects_path(notice: 'Project created successfully.')
    else
      render :new
    end
    
  end

  def edit
    @project = Project.find_by(slug: params[:id])
  end

  def update
    @project = Project.find_by(slug: params[:id])
    if @project.update(project_params)
      redirect_to edit_project_path(notice: 'Project updated successfully.')
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find_by(slug: params[:id])
    @project.destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :private,)
  end

end
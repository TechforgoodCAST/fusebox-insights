
class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create edit update destroy]
  before_action :set_project

  def index
    @projects = current_user.created_projects
  end
  
  def show
    authorize @project
  end
  
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user    
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
      redirect_to edit_project_path, notice: 'Project updated successfully.'
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
      @project = Project.find_by(slug: params[:slug])
    end

    def project_params
      params.require(:project).permit(:name, :description, :is_private, :slug)
    end

end
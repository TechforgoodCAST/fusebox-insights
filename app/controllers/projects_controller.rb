
class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @projects = current_user.projects
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  def new
    # empty (for now)
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    # TODO: add user
    if @project.save
      redirect_to @project, notice: 'Project created successfully.'
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
      redirect_to @project, notice: 'Project updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to action: 'index'
  end

  private

    def project_params
      params.require(:project).permit(:name)
    end

end
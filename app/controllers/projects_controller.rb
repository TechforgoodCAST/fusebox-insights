
class ProjectsController < ApplicationController
  before_action :authenticate_user!, :except => :show
  before_action :can_access_admin_pages, :except => [:show, :new, :index, :create]
  before_action :is_project_public, :only => :show

  def index
    @user = current_user
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
      redirect_to action: 'index', notice: 'Project created successfully.'
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
      redirect_to edit_project_path, notice: 'Project updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find_by(slug: params[:id])
    @project.destroy
    redirect_to action: 'index'
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :private,)
  end

  def can_access_admin_pages
    unless Project.find_by(slug: params[:id]).user == current_user
      return head :forbidden
    end
  end

  def is_project_public
    @current_project = Project.find_by(slug: params[:id])
    unless @current_project.private == false || @current_project.user == current_user
      return head :forbidden
    end
  end

end
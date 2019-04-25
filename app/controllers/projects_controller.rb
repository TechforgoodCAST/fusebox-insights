# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_project, except: %i[index new create]

  def index
    @projects = current_user.projects
  end

  def knowledge_board
    @unknowns = Unknown.we_do_not_know.order(updated_at: :desc)
    @think_knowns = Unknown.we_think_we_know.order(updated_at: :desc)
    @knowns = Unknown.we_know.order(updated_at: :desc)
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
    slug = (params[:slug].present?) ? params[:slug] : params[:project_slug]
    @project = Project.find_by(slug: slug)
  end

  def project_params
    params.require(:project).permit(:name, :description, :is_private)
  end
end

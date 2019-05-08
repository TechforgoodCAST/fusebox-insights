# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: %i[show knowledge_board assumptions]
  before_action :set_project, except: %i[index new create]

  def index
    @projects = current_user.projects
  end

  def knowledge_board

    authorize @project

    @assumptions = @project.assumptions.we_do_not_know.order(updated_at: :desc)
    @think_knowns = @project.assumptions.we_think_we_know.order(updated_at: :desc)
    @knowns = @project.assumptions.we_know.order(updated_at: :desc)

  end

  def assumptions

    authorize @project
    @assumptions = @project.assumptions.order(updated_at: :desc).page(params[:page])

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
    @project = Project.friendly.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :is_private)
  end
end

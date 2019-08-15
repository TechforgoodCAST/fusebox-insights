# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects.order(title: :desc)
                            .select('projects.*', 'memberships.role')

    @contributor = @projects.select { |p| p.role == Membership.roles['contributor'] }
    @stakeholder = @projects.select { |p| p.role == Membership.roles['stakeholder'] }
    @mentor = @projects.select { |p| p.role == Membership.roles['mentor'] }
  end

  def show
    @project = authorize Project.find(params[:id])
  end

  def new
    @project = authorize Project.new
  end

  def create
    @project = authorize Project.new(project_params)
    @project.users << current_user

    if @project.save
      redirect_to project_path(@project), notice: 'Welcome to your new project!'
    else
      render :new
    end
  end

  def edit
    @project = authorize Project.find(params[:id])
  end

  def update
    @project = authorize Project.find(params[:id])

    if @project.update(project_params)
      redirect_to about_project_path(@project)
    else
      render :edit
    end
  end

  def about
    @project = authorize Project.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:description, :more_details, :title)
  end
end

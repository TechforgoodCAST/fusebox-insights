# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, except: :index

  def index
    @projects = current_user.projects.order(title: :desc)
                            .select('projects.*', 'memberships.role')

    @contributor = @projects.select { |p| p.role == Membership.roles['contributor'] }
    @stakeholder = @projects.select { |p| p.role == Membership.roles['stakeholder'] }
    @mentor = @projects.select { |p| p.role == Membership.roles['mentor'] }
  end

  def show
    authorize @project, policy_class: ProjectPolicy
  end

  def new
    @project = authorize Project.new
  end

  def create
    @project = authorize Project.new(project_params)
    @project.users << current_user

    if @project.save
      @project.milestones.create(Milestone::PRESETS)
      redirect_to project_path(@project), notice: 'Welcome to your new project!'
    else
      render :new
    end
  end

  def edit
    authorize @project, policy_class: ProjectPolicy
  end

  def update
    authorize @project

    if @project.update(project_params)
      redirect_to about_project_path(@project)
    else
      render :edit
    end
  end

  def about
    authorize @project, policy_class: ProjectPolicy
  end

  private

  def project_params
    params.require(:project).permit(:description, :more_details, :title)
  end
end

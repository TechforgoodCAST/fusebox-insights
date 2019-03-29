
class SupportMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_support_message
  before_action :set_project
  
  def index
    @support_messages = @project.support_messages.order(:order)
  end

  def show
    # empty
  end
  
  def new
    authorize @support_message = SupportMessage.new(project: @project)
  end
  
  def create
    @support_message = SupportMessage.new(support_message_params)
    @support_message.project = @project
    if @support_message.save
      redirect_to support_messages_path, notice: 'Support message created successfully.'
    else
      render :new
    end
  end

  def edit
    authorize @support_message
  end
  
  def update
    authorize @support_message
    if @support_message.update(support_message_params)
      redirect_to support_messages_path(slug: @support_message.project.slug), notice: 'Support message updated successfully.'
    else
      render :edit
    end
  end
  
  def destroy
    authorize @support_message
    @support_message.destroy
    redirect_to support_messages_path(slug: @support_message.project.slug), notice: 'Support message destroyed successfully.'
  end
  
  private

    def set_support_message
      @support_message = SupportMessage.find_by(id: params[:id])
    end

    def set_project
      @project = Project.find_by(slug: params[:slug])
    end

    def is_user_project_creator
      current_user == @project.user
    end

    def support_message_params
      params.require(:support_message).permit(
        :body,
        :order,
        :status,
        :status,
        :rule_object_type,
        :rule_event_type,
        :rule_occurrences
      )
    end

end
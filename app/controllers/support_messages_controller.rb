
class SupportMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_support_message
  
  def index
    @project = Project.find_by(slug: params[:project_slug])
    @support_messages = @project.support_messages.order(:order)
  end

  def show
    # empty
  end
  
  def new
    @support_message = SupportMessage.new
  end
  
  def create
    @current_project = Project.find_by(slug: params[:project_slug])
    @new_message = SupportMessage.new(support_message_params)
    @new_message.status = 'Pending'
    @new_message.project = @current_project
    if @new_message.save
      redirect_to support_message_path, notice: 'Support message created successfully.'
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
      redirect_to edit_support_message_path, notice: 'Support message updated successfully.'
    else
      render :edit
    end
  end
  
  def destroy
    authorize @support_message
    @support_message.destroy
    redirect_to support_message_path, notice: 'Support message destroyed successfully.'
  end
  
  private

    def set_support_message
      @support_message = SupportMessage.find_by(id: params[:id])
    end

    def support_message_params
      params.require(:support_message).permit(:body, :order, :status)
    end

end
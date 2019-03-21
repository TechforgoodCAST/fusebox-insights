
class SupportMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :support_messsage_related_to_user, :except => [:new, :create, :index]
  
  def index
    @project = Project.find_by(slug: params[:project_slug])
    @support_messages = @project.support_messages.order(:order)
  end

  def show
    @support_message = SupportMessage.find(id: params[:id])
  end
  
  def new
    # empty (for now)
  end
  
  def create
    @current_project = Project.find_by(slug: params[:project_slug])
    @new_message = SupportMessage.new(support_message_params)
    @new_message.status = 'Pending'
    @new_message.project = @current_project
    if @new_message.save
      redirect_to action: 'index', notice: 'Support message created successfully.'
    else
      render :new
    end
  end

  def edit
    @support_message = SupportMessage.find_by(id: params[:id])
  end
  
  def update
    @support_message = SupportMessage.find_by(id: params[:id])
    if @support_message.update(support_message_params)
      redirect_to edit_support_message_path, notice: 'Support message updated successfully.'
    else
      render :edit
    end
  end
  
  def destroy
    @support_message = SupportMessage.find_by(id: params[:id])
    @support_message.destroy
    redirect_to action: 'index'
  end
  
  private

    def support_message_params
      params.require(:support_message).permit(:body, :order, :status)
    end

    def support_messsage_related_to_user
      unless SupportMessage.find_by(id: params[:id]).project.user == current_user
        return head :forbidden
      end
    end

end
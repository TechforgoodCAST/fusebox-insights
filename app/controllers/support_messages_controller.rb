
class SupportMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :support_messsage_related_to_user, :except => [:new, :index]
  
  def index
    @support_messages = SupportMessage.find_by(project_id: params[:project_id])
  end

  def show
    @support_message = SupportMessage.find(id: params[:id])
  end
  
  def new
    # empty (for now)
  end
  
  def create
    @new_message = SupportMessage.new(support_message_params)
    @current_project = Project.find_by(id: params[:project_id])
    @new_message.project = @current_project
    if @new_message.save
      redirect_to action: 'index', notice: 'Support message created successfully.'
    else
      render :new
    end

  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private

    def support_message_params
    end

    def support_messsage_related_to_user
      unless SupportMessage.find_by(id: params[:id]).project.user == current_user
        return head :forbidden
      end
    end

end
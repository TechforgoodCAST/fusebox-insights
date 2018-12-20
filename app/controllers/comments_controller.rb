# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @unknown = Unknown.find_by(id: params[:id])

    @comment.author = current_user
    @comment.unknown = @unknown

    if @comment.save
      redirect_to unknown_path(@unknown), notice: 'Insight successfully added.'
    else
      render 'unknowns/show'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:confidence, :description, :title)
    end
end

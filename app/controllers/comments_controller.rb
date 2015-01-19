class CommentsController < ApplicationController
  def index
    @comments = Comment.all
    respond_to do |format|
      format.html
      format.json {render json: @comments}
    end
  end

  def create
    Comment.create!(params.permit(:author, :text))

    render json: Comment.all
  end
end

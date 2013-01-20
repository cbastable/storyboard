class CommentsController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @comment = Comment.new(params[:comment])
    @story = @comment.story
    if @story.comment!(@comment)
      @comments = @story.comments.paginate(per_page: 10, page: params[:page])
      respond_to do |format|
        format.html {redirect_to story_path(@story)}
        format.js
      end
    else
      respond_to do |format|
        format.html {redirect_to story_path(@story)}
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @story = @comment.story
    @story.uncomment!(@comment)
    respond_to do |format|
      format.html {redirect_to story_path(@story)}
      format.js
    end
  end
  
end
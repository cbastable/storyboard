class CommentsController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @story = Story.find_by_id(params[:story_id])
    @comment = @story.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment pinned!"
      respond_to do |format|
        format.html {redirect_to story_path(@story)}
        format.js
      end
    else
      flash[:error] = "Could not post"
      respond_to do |format|
        format.html {redirect_to story_path(@story)}
        format.js
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to story_path(@story)}
      format.js
    end
  end
  
end
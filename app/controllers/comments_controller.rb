class CommentsController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @story = Story.find_by_id(params[:story_id])
    @comment = @story.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment pinned!"
      redirect_to story_path(@story)
    else
      flash[:error] = "Could not post"
      redirect_to story_path(@story)    ##this is kind of buggy still
    end
  end

  def destroy
    @comment.destroy
    redirect_to root_path
  end
  
end
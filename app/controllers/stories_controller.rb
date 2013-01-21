class StoriesController < ApplicationController
before_filter :signed_in_user, only: [:new, :create, :show, :edit, :destroy]
before_filter :correct_user, only: [:edit, :destroy]


def new
  @story = Story.new
  @stats = Stat.new
end

def create
  @story = current_user.stories.build(params[:story])
  @board = current_user.boards.build(name: "Published", story_id: @story.id)
  if @story.save
    @stat = @story.stats.build(viewer_id: current_user.id, viewed: true)
    @stat.save
    @board.save
    flash[:success] = "Story pinned successfully"
    redirect_to story_path(@story)
  else
    render 'new'
  end
end

def show
  @story = Story.find_by_id(params[:id])
  @comments = @story.comments.paginate(per_page: 10, page: params[:page])
  @user = @story.user
  @preview = @story.preview(@story)
  @stats = @story.stats.find_by_viewer_id(current_user.id)
  if signed_in?
    @comment = @story.comments.build
    @comment.user_id = current_user.id
  end
  respond_to do |format|
        format.html
        format.js
      end
end

def edit
  @story = Story.find(params[:id])
end

def update
  @story = Story.find_by_id(params[:id])
  if @story.update_attributes(params[:story])
    flash[:success] = "Story updated successfully"
    redirect_to story_path
  else
    render 'edit'
  end
end

def destroy
  current_user.stories.find_by_id(params[:id]).destroy
  flash[:sucess] = "Story destroyed"
  redirect_to @current_user
end

def comments
  @comments = @story.comments.paginate(page: params[:page])
  render 'show_comments'
end

def upvote
    @stat = Stat.find(params[:id])
    Stat.increment_counter(:rating, @stat.id)
    @story = @stat.story
    respond_to do |format|
      format.html {redirect_to story_path(@story)}
      format.js
    end
end

def downvote
    @stat = Stat.find(params[:id])
    Stat.decrement_counter(:rating, @stat.id)
    @story = @stat.story
    respond_to do |format|
      format.html {redirect_to story_path(@story)}
      format.js
    end
end

def no_vote
    @stat = Stat.find(params[:id])
    @stat.rating = nil
    @stat.save!
    @story = @stat.story
    respond_to do |format|
      format.html {redirect_to story_path(@story)}
      format.js
    end
end


private
  
  def correct_user
    @user = Story.find_by_id(params[:id]).user
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end


end 

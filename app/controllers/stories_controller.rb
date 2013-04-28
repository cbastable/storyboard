class StoriesController < ApplicationController
before_filter :signed_in_user, only: [:new, :create, :edit, :destroy]
before_filter :correct_user, only: [:edit, :destroy]


def new
  @story = Story.new
  @stats = Stat.new
end

def index
  @user = current_user
  @per_page = 16
  
  @stories = Story.search( params[:search], page: params[:page], per_page: @per_page, conditions: {},
                                            order: :created_at, sort_mode: :desc)
  
  respond_to do |format|
    format.html
    format.js
  end
  
  
end

def create
  @story = current_user.stories.build(params[:story])
  if @story.save
    @stat = @story.stats.build(viewer_id: current_user.id, viewed: true)
    @stat.save
    @board = current_user.boards.create!(name: "Published", story_id: @story.id)
    flash[:success] = "Story pinned successfully"
    redirect_to story_path(@story)
  else
    render 'new'
  end
end

def show
  @story = Story.find_by_id(params[:id])
  @comments = @story.comments.paginate(per_page: 10, page: params[:page])
  @author = @story.user
  @preview = @story.preview(@story)
  if signed_in?
    @user = current_user
    @stats = @story.stats.find_by_viewer_id(current_user.id)
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
  Board.where(story_id: params[:id]).each do |board|
    board.destroy
  end
  flash[:sucess] = "Story deleted"
  redirect_to @current_user
end

def comments
  @comments = @story.comments.paginate(page: params[:page])
  render 'show_comments'
end

def upvote
    @story = Story.find(params[:id])
    Story.increment_counter(:upvotes, @story.id)
    @stat = @story.stats.find_by_viewer_id(current_user.id)
    @stat.rated = true
    @stat.save
    @user = current_user
    respond_to do |format|
      format.html {redirect_to story_path(@story)}
      format.js
    end
end

def downvote
    @story = Story.find(params[:id])
    Story.decrement_counter(:upvotes, @story.id)
    @stat = @story.stats.find_by_viewer_id(current_user.id)
    @stat.rated = true
    @stat.save
    @user = current_user
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

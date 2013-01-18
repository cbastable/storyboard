class StoriesController < ApplicationController
before_filter :signed_in_user, only: [:new, :create, :show, :edit, :destroy]
before_filter :correct_user, only: [:edit, :destroy]


def new
  @story = Story.new
  @stats = Stat.new
end

def create
  @story = current_user.stories.build(params[:story])
  @stats = @story.stats.build(viewer_id: current_user.id, viewed: true)
  if @story.save
    @stats.save
    flash[:success] = "Story pinned successfully"
    redirect_to current_user_path
  else
    render 'new'
  end
end

def show
  @story = Story.find_by_id(params[:id])
  @views = @story.stats.find(:all, group: 'viewer_id').count
  if Stat.find(:all, conditions: {story_id: @story.id, viewer_id: current_user.id}).nil?
    @stats = @story.stats.build(viewer_id: current_user.id, viewed: true)
    @stats.save
  end
  @comments = @story.comments.paginate(page: params[:page])
  if signed_in?
    @comment = @story.comments.build
    @comment.user_id = current_user.id
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


private
  
  def correct_user
    @user = Story.find_by_id(params[:id]).user
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end


end 

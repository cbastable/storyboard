class StoriesController < ApplicationController
before_filter :signed_in_user, only: [:new, :create, :edit, :destroy]
before_filter :correct_user, only: [:edit, :destroy]


def new
  @story = Story.new
end

def create
  @story = current_user.stories.build(params[:story])
  if @story.save
    flash[:success] = "Story pinned successfully"
    redirect_to @story_url
  else
    render 'new'    #can we not delete the story already submitted with this method? test to make sure
  end
end

def show
  @story = Story.find(params[:id])
end

def edit
  @story = Story.find(params[:id])
end

def update
  if @story.update_attributes(params[:story])
    flash[:success] = "Story updated successfully"
    redirect_to story_path
  else
    render 'edit'
  end
end

def destroy
  current_user.stories.find(params[:id]).destroy
  flash[:sucess] = "Story destroyed"
  redirect_to @current_user
end


private
  
  def correct_user
    @user = Story.find(params[:id]).user
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end


end 

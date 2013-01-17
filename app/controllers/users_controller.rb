class UsersController < ApplicationController
  before_filter :signed_in_user,
                only: [:index, :edit, :update, :destroy, :publishers, :subscribers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def new
    if signed_in?
      flash[:notice] = "You are already signed in to an account"
      redirect_to root_url
    else
      @user = User.new
    end 
  end
  
  def show
    @user = User.find(params[:id])
    @user_stories = @user.stories
    @comments = @user.comments.paginate(page: params[:page])
  end
  
  def create
    if signed_in?
      flash[:notice] = "You are already signed in to an account"
      redirect_to root_url
    else  
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to StoryBoard!"
        redirect_to @user
      else
        render 'new'
      end
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated!"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_url
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def publishers
    @title = "Publishers"
    @user = User.find(params[:id])
    @users = @user.publishers.paginate(page: params[:page])
    render 'show_relationships'
  end
  
  def readers                                   # bad naming - subscribers vs. readers
    @title = "Subscribers"
    @user = User.find(params[:id])
    @users = @user.readers.paginate(page: params[:page])
    render 'show_relationships'
  end

  private
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end #end of Users Controller

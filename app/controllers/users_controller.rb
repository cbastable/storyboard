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
  
  def create
    if signed_in?
      flash[:notice] = "You are already signed in to an account"
      redirect_to root_url
    else  
      @user = User.new(params[:user])
      if @user.save
        @user.update_community_points!(@user, 400)
        flash[:success] = "Added to beta! We'll be in touch..."
        redirect_to root_path
      else
        render 'new'
      end
    end
  end
end #end of Users Controller

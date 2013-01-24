class GenresController < ApplicationController
  before_filter :admin_user, only: [:create, :destroy]
  

  def create
    @genre = Genre.new(params[:genre])
  end

  def destroy
    @genre = Genre.find(params[:id]).destroy
  end
  
  def show
    @user = current_user
    @genre = Genre.find(params[:id])
    @primary_stories = @genre.primary_stories.scoped.paginate(page: params[:page], per_page: params[:per_page] || 0)
    @secondary_stories = @genre.secondary_stories.paginate(page: params[:page], per_page: params[:per_page] || 0)
    @tertiary_stories = @genre.tertiary_stories.paginate(page: params[:page], per_page: params[:per_page] || 0)
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def index
    @genres = Genre.paginate(page: params[:page])
  end
  


private
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
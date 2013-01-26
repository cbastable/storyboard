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
    
    #@primary_stories = @genre.primary_stories.scoped.paginate(page: params[:page], per_page: params[:per_page] || 0)
    #@stories = Story.search params[:search], include: :SOMETHING, page: 1, per_page: 24, order: :created_at, conditions: {genre_1: 'SOMETHING', created_at: 1.week.ago.to_i..Time.now.to_i }
    # , page: params[:page] || 16, per_page: 16,
    
    @stories = Story.search( params[:search], page: params[:page], per_page: 10, conditions: {genre_1: @genre.name, author: "Example User"},
                                            order: :created_at, sort_mode: :desc)
    
    
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
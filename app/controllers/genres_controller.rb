class GenresController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:new, :index, :create, :destroy]
  
  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.create(params[:genre])
    if @genre.save
      flash[:success] = "Genre added successfully"
      redirect_to genres_path
    else
      render 'new'
    end
  end

  def destroy
    @genre = Genre.find(params[:id]).destroy
  end
  
  def show
    @user = current_user
    @genre = Genre.find(params[:id])
    @per_page = 16
    
    #@primary_stories = @genre.primary_stories.scoped.paginate(page: params[:page], per_page: params[:per_page] || 0)
    #@stories = Story.search params[:search], include: :SOMETHING, page: 1, per_page: 24, order: :created_at, conditions: {genre_1: 'SOMETHING', created_at: 1.week.ago.to_i..Time.now.to_i }
    # , page: params[:page] || 16, per_page: 16,
    
    @stories = Story.search( params[:search], page: params[:page], per_page: @per_page, conditions: {genre_1: @genre.name},
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
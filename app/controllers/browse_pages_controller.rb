class BrowsePagesController < ApplicationController
  #before_filter :signed_in_user

  def splash
    @user = User.new
  end

  def home
    if signed_in?
      @user = current_user
      @publishers = @user.publishers.last(10)
    end
    
    @authors = User.last(10)
    
    #below is janky/awful
    @genres_per_page = 5
    @per_page = 5
    @genres = Genre.scoped.paginate(page: params[:page], per_page: params[:per_page] || @genres_per_page)
    @new_stories = Story.scoped.paginate(page: params[:new_stories_page], per_page: params[:per_page] || @per_page)
    @genre_stories = @genres.inject({}) do |hash, genre|
      hash[genre] = genre.primary_stories.scoped.paginate(page: params[:"#{genre.name}"],
                                                          per_page: params[:per_page] = @per_page)
      hash
    end
    
    if params[:param_name] == "new_stories_page"
      respond_to do |format|
        format.html
        format.js {render "new_stories.js.erb"}
      end
    else if params[:param_name] == nil
      respond_to do |format|
        format.html
        format.js {render "home.js.erb"}
      end
    else
      @genre = Genre.find_by_name(params[:param_name])
       respond_to do |format|
        format.html
        format.js {render "genre_stories.js.erb"}
      end
    end
    
    
    
  
    
  end
  end
  
  
  end

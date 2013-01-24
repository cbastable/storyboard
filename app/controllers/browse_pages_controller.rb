class BrowsePagesController < ApplicationController
  before_filter :signed_in_user

  def home
    @user = current_user
    @publishers = @user.publishers.last(10)
    @recommended_stories = []
    @new_stories = Story.scoped.paginate(page: params[:new_stories_page], per_page: params[:per_page] || 12)
    @genres = Genre.scoped.paginate(page: params[:page], per_page: params[:per_page] || 0)
    
    if params[:param_name] == "new_stories_page"
      respond_to do |format|
        format.html
        format.js {render "new_stories.js.erb"}
      end  
    else
      respond_to do |format|
        format.html
        format.js {render "home.js.erb"}
      end
    end
    
  end
  
  

  
end


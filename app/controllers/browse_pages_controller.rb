class BrowsePagesController < ApplicationController
  before_filter :signed_in_user

  def home
      @user = current_user
      @publishers = @user.publishers.last(10)
      @recommended_stories = []
      @new_stories = Story.last(10)
  end

  
end
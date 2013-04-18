class StatsController < ApplicationController
  before_filter :signed_in_user

  def create
    @story = Story.find(params[:stat][:story_id])
    
    if params[:commit] == 'Pay with Storyboard Points' && current_user.storyboard_points >= @story.price
      @balance = current_user.storyboard_points
      current_user.update_storyboard_points!(current_user, @balance - @story.price) 
      @stat = Stat.new(params[:stat])
      @stat.story.add_to_stats!(@stat)
      @story = @stat.story
      @user = @story.user
      @stats = @story.stats.find_by_viewer_id(current_user.id)
      @board = current_user.boards.create!(name: "Read", story_id: @story.id)
      flash[:success] = "Story added to your library"
    end
    
    respond_to do |format|
      format.html {redirect_to story_path(@story)}
      format.js
    end
    
  end

end
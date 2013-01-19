class StatsController < ApplicationController
  before_filter :signed_in_user

  def create
    @stat = Stat.new(params[:stat])
    @stat.story.add_to_stats!(@stat)
    @story = @stat.story
    respond_to do |format|
      format.html {redirect_to story_path(@story)}
      format.js
    end
  end

end
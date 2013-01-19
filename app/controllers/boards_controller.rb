class BoardsController < ApplicationController
  before_filter :signed_in_user

  def create
    @board = Board.new(params[:board])
    current_user.add_to_storyboard!(@board)
    @story = Story.find_by_id(@board.story_id)
    respond_to do |format|
      format.html {redirect_to story_path(@story)}
      format.js
    end
  end

  def destroy
    @board = Board.find(params[:id])
    current_user.remove_from_storyboard!(@board)
    respond_to do |format|
      format.html {redirect_to current_user_user_path}
      format.js
    end
  end

end
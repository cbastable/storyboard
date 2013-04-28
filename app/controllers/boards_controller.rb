class BoardsController < ApplicationController
  before_filter :signed_in_user

  def create
    @board = Board.new(params[:board])
    @user = current_user
    if params[:commit] == 'Add to storyboard'
      current_user.add_to_storyboard!(@board)
      @story = Story.find_by_id(@board.story_id)
      respond_to do |format|
        format.html {redirect_to story_path(@story)}
        format.js {render "create.js.erb" }
      end
    else
      current_user.add_to_storyboard!(@board)
      @story = Story.find_by_id(@board.story_id)
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js {render "read_later.js.erb"}
      end
    end
  end

  def destroy
    if params[:commit] == 'Delete'
      current_user.boards.where(name: current_user.boards.find_by_id(params[:id]).name).destroy_all
      respond_to do |format|
        format.html 
        format.js
      end
    else
      @board = Board.find_by_id(params[:id])
      current_user.remove_from_storyboard!(@board)
      respond_to do |format|
        format.html {redirect_to current_user_user_path}
        format.js
      end      
    end
  end

end
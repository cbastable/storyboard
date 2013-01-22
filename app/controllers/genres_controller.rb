class GenresController < ApplicationController
  before_filter :admin_user

  def create
    @genre = Genre.new(params[:genre])
  end

  def destroy
    @genre = Genre.find(params[:id]).destroy
  end


private
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
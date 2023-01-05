class Admin::GenresController < ApplicationController
  
  def index
    @genre = Genre.new
    @genres = Genre.all
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def create
    @gebre = Genre.new
    @genre.save
    redirect_to admin_genres_path
  end
  
  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end

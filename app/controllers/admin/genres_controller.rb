class Admin::GenresController < ApplicationController
  def new
    @genre = Genre.new
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to admin_genres_path
  end

  def index
  end

  def edit
  end

  def genre_params
    params.require(:genre).permit(:name)
  end

end

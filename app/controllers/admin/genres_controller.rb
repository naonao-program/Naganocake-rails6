class Admin::GenresController < ApplicationController
  def index
    @genre_new = Admin::Genre.new
    @genres = Admin::Genre.all
  end

  def create
    @genre_new = Admin::Genre.new(genre_params)
    if @genre_new.save
      redirect_to genres_path
    else
      @genres = Genre.all
      render :index
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end

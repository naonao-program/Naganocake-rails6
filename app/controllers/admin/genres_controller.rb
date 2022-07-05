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

  def edit
    @genre = Admin::Genre.find(params[:id])
  end

  def update
    @genre = Admin::Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genres_path
    else
      render :edit
    end
  end

  private
  def genre_params
    params.require(:admin_genre).permit(:name)
  end
end

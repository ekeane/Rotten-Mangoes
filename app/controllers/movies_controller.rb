class MoviesController < ApplicationController

before_filter :authorize, except: [:index, :show]


  def index
    @movies = Movie.all
   if params[:query]
      @movies = @movies.where("title LIKE ? OR director LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%") 
   end

  case params[:search]
    when "Under 90 minutes"
        @movies = @movies.where("runtime_in_minutes < ?", 90)
    when "Between 90 and 120 minutes"
      @movies = @movies.where("runtime_in_minutes BETWEEN ? AND ? ", 90, 120)
    when "Over 120 minutes"
    @movies = @movies.where("runtime_in_minutes > ?", 120)
  else 
    nil
  end
end


  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description
    )
  end
end
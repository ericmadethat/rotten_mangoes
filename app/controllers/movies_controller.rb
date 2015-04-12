class MoviesController < ApplicationController
  before_action :set_movie, except: [:index, :new, :create]

  def index
    if params[:title] || params[:director] || params[:runtime_in_minutes]
      @movies = Movie.search(params[:title], params[:director], params[:runtime_in_minutes])
    else
      @movies = Movie.all
    end
  end
    # if params[:title] || params[:director] || params[:runtime_in_minutes]
    #   min_runtime = 0
    #   max_runtime = 240
    #   case params[:runtime_in_minutes]
    #   when 2
    #     max_runtime = 90
    #   when 3
    #     min_runtime = 90
    #     max_runtime = 120
    #   when 4
    #     min_runtime = 120
    #   end
    #   @movies = Movie.where("title LIKE ? AND director LIKE ? AND runtime_in_minutes BETWEEN ? AND ?", "%#{params[:title]}%", "%#{params[:director]}%", min_runtime, max_runtime)
    # else
    #   @movies = Movie.all
    # end

  def new
    @movie = Movie.new
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
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end

  protected
  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image, :remote_image_url
    )
  end


  def set_movie
    @movie = Movie.find(params[:id]) if params[:id]
  end

end

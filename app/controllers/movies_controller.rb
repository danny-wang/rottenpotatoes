class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort_by = params[:sort_by]
    if @sort_by
      session[:sort_by]=@sort_by
    end
    if session[:sort_by] == "release_date"
      query = Movie.order(:release_date)
    elsif session[:sort_by] == "title"
      query = Movie.order(:title)
    else
      query = Movie
    end
    
    @all_ratings = Movie.ratings
    if  !params[:ratings].nil?
      session[:ratings]=params[:ratings].map { |r| r[0] }
      @ratings = params[:ratings].map { |r| r[0] }
      @movies = query.where(rating: session[:ratings])
    elsif session[:ratings]
      @ratings =session[:ratings]
      @movies = query.where(rating: session[:ratings])
      
    else
      @movies = query.all
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  def search_tmdb
    #hardwire to simulate failure
    flash[:warning]="'#{params[:search_terms]}' was not found in TMDb."
    redirect_to movies_path
  end
  

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      # @movies = Movie.all
      # @all_ratings = ['G', 'PG', 'PG-13', 'R']
      # @all_ratings = Movie.ratings
      
      
      @url = request.original_url
      if ! (@url =~ /movies/) # url does not contain /movies/ 
        session.clear
      end
      
      @checks = params[:ratings] == nil ? @all_ratings : params[:ratings].keys
      
      if params[:sort] || session[:sort]
        if params[:sort]
          @movies = Movie.order(params[:sort])
        elsif session[:sort]
          @movies = Movie.order(session[:sort])
        end
        
        session[:sort] = params[:sort]
        
      else
        @movies = Movie.all
        # session[:sort] = nil
      end
      
      
      if params[:ratings] || session[:ratings]
        if params[:ratings]
          @params_ratings = params[:ratings]
          
        elsif session[:ratings]
          @params_ratings = session[:ratings]
        end
        @movies = Movie.with_ratings(@params_ratings.keys).order(params[:sort])
        session[:ratings] = params[:ratings]
      end
        
      
      @all_ratings = Movie.ratings
      
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
  
    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      redirect_to movies_path
    end
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  end
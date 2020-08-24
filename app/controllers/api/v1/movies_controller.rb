class Api::V1::MoviesController < ApplicationController
    before_action :set_movie, only: [:show, :update, :destroy]
    skip_before_action :authenticate, only: [:index, :show]
  
    # GET /movies
    def index
      @movies = Movie.all
      render json: @movies
    end
  
    #GET /movies/1
    def show
      @reviews = Review.where(movie_id: params[:id])
      render json: { movie: @movie, reviews: @reviews }
    end
  
    #POST /movies
    def create
      @movie = Movie.new(movie_params)
      if @movie.save
        render json: @movie
      else
        render json: @movie.errors, status: :unprocessable_entity
      end
    end
  
    #PATCH/PUT /movies/1
    def update
      if @movie.update(movie_params)
        render json: @movie
      else
        render json: @movie.errors, status: :unprocessable_entity
      end
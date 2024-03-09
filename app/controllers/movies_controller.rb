# frozen_string_literal: true

include Ransack::Helpers::FormHelper

class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]

  def index
    @q = Movie.ransack(params[:q])

    # Get the sorted movies based on average stars
    @movies = Movie.joins(:reviews)
                   .select('movies.*, AVG(reviews.stars) AS avg_stars', :reviews)
                   .group('movies.id')
                   .order('avg_stars DESC')

    # Apply Ransack search conditions
    @movies = @q.result(distinct: true)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie was successfully created.'
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_url, notice: 'Movie was successfully destroyed.'
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :year, :director, :actor, :filming_location, :country)
  end
end

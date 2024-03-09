# frozen_string_literal: true

namespace :import do
  desc 'Import data from CSV files'

  task from_csv: :environment do
    require 'csv'

    # Define the paths to your CSV files
    movies_csv_path = Rails.root.join('db', 'data', 'movies.csv')
    reviews_csv_path = Rails.root.join('db', 'data', 'reviews.csv')

    # Import movies from movies.csv
    CSV.foreach(movies_csv_path, headers: true) do |row|
      Movie.find_or_create_by(
        title: row['Movie'],
        year: row['Year'],
        director: row['Director'],
        actor: row['Actor'],
        filming_location: row['Filming location'],
        country: row['Country']
      )
    end

    # Import reviews from reviews.csv
    CSV.foreach(reviews_csv_path, headers: true) do |row|
      movie = Movie.find_by(title: row['Movie'])
      Review.create(
        movie:,
        user: row['User'],
        stars: row['Stars'],
        review: row['Review']
      )
    end

    puts 'Data imported successfully!'
  end
end

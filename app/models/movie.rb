# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, presence: true
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 1900 }

  has_many :reviews
  def self.ransackable_attributes(_auth_object = nil)
    %w[actor country created_at director filming_location id title updated_at year]
  end
end

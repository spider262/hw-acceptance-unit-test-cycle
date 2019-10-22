class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  # find a group of record with the same director
  def same_director
    return Movie.where("director = ?", self.director)
  end
end

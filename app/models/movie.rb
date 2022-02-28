class Movie < ActiveRecord::Base
    def self.ratings
       return ['G','PG','PG-13','R']
    end
    
    
    def self.with_ratings(keys)
        movies = self.where("rating IN (?)", keys)
        return movies
    end
    
end
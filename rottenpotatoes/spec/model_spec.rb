require 'rails_helper'

describe Movie do
    describe "#same_director" do
        it "should find movies by the same director" do
            movie1=Movie.create! :director => 'Paul'
            movie2=Movie.create! :director => 'Paul'
            expect(movie1.same_director).to include(movie2)
        end
        it "should not find movies by different directors" do
            movie1=Movie.create! :director => 'John'
            movie2=Movie.create! :director => 'Spencer'
            expect(movie1.same_director).not_to include(movie2)
        end
    end
end
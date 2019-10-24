#require 'simplecov'
#SimpleCov.start 'rails'
require 'rails_helper'

describe MoviesController, type: :controller do
  describe "#director"do
    context "When the movie has a director" do
      it "should find all movies with the same director" do
        movie1 = Movie.create(:title => 'test', :director => 'fake_director')
        movie2 = Movie.create(:title => 'test2', :director => 'fake_director')
        get :director, {:id => "#{movie1.id}"}#"#{@fake_movie2.id}"}
        expect(response).to render_template(:director)
      end
    end

    context "When the movie has no director" do
      it "should redirect to the movies page" do
        movie = Movie.create(:title => 'fake', :director => '')
        get :director, {:id => "#{movie.id}"}
        expect(response).to redirect_to("/movies")
      end
    end
  end

  describe "#sort"do
    context "When sort by director" do
      it "should sort all movies by director's name" do
        get :index, :sort => :director, :ratings => ["R","PG", "G", "PG", "PG-13"]
      end
    end
    context "When sort by title" do
      it "should sort all movies by title" do
        get :index, :sort => :title, :ratings => ["R","PG", "G"]
      end
    end
    context "When sort by release_date" do
      it "should sort all movies by release_date" do
        get :index, :sort => :release_date, :ratings => ["G", "PG", "PG-13"]
      end
    end
  end

  describe "#new" do
    context "When create a movie" do
      it "should create it to database" do
        movie_new = Hash.new
        movie_new["title"] = "test_new_movie"
        movie_new["rating"] = "G"
        movie_new["release_date"] = Date.new(1970, 1, 1)
        movie_new["director"] = "test_new_director"

        post :create, movie: movie_new
        expect(response).to redirect_to("/movies")
      end
    end
  end
  
  describe "#create" do
    it "should create movie with provided parameters" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        @defaults = { :title => "Terrible Movie", :rating => "G", :director => "Dr. V" }
        expect(Movie).to receive(:create!).and_return(@movie)
        post :create, :movie => @defaults
        expect(response).to redirect_to(movies_path)
    end
  end
  
  describe "#show" do
    it "should display details about an existing movie" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        expect(Movie).to receive(:find).and_return(@movie)
        get :show, :id => @movie_id
        expect(response).to render_template(:show)
    end
  end
  
  describe "#destroy" do
    it "should delete the specific movie" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
        expect(@movie).to receive(:destroy)
        delete :destroy, :id => @movie_id
        expect(response).to redirect_to(movies_path)
    end
  end
  
  describe "#edit" do
    it "should edit an existing movie" do
        @movie_id = "1234"
        @movie = double('fake movie').as_null_object
        expect(Movie).to receive(:find).and_return(@movie)
        get :edit, :id => @movie_id
        expect(response).to render_template(:edit)
    end
  end
  
end  
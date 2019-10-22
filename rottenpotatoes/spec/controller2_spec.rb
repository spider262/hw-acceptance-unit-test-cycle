require 'simplecov'
SimpleCov.start 'rails'
require 'rails_helper'

describe MoviesController, type: :controller do
    #before(:each) do
    #    @movie_1 = Movie.create(title: "title_1",rating: "G", description:"we are here", director: "abc123",release_date: 20161123)
    #end

    describe "#director" do
        context "When specified movie has a director" do
            it 'should call Movie.find_with_same_director' do
              expect(Movie).to receive(:find).with('Aladdin')
              get :same_director, { title: 'Aladdin' }
            end
        end
        context "When specified movie has no director" do
            it 'should assign similar movies if director exists' do
              movies = ['Seven', 'The Social Network']
              Movie.stub(:director).with('Seven').and_return(movies)
              get :search, { title: 'Seven' }
              expect(assigns(:same_director)).to eql(movies)
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
  describe "#new" do
    it "should render the new template" do
        # the new method doesn't actualy do anything besides render new.html.haml
        get :new 
        expect(response).to render_template(:new)
    end
  end
end
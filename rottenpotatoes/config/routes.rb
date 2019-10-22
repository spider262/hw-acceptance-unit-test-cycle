Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  # New function in HW3
  get 'movies/director/:id', to: 'movies#director', as: 'movies_director'
end

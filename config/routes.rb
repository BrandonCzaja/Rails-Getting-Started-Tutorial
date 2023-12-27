Rails.application.routes.draw do
  # Set the root route to match index
  root "articles#index"

  # Provides the CRUD routes for @articles
  # Resources only creates the routes - I still need the controller actions
  resources :articles do
    # This creates comments as a nested resources within articles - 
      # another part of capturing the hierarchical relationship between articles and comments
    resources :comments
  end
end

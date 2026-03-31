Rails.application.routes.draw do
  resources :users

  # POSTs
  get  "/posts",               to: "posts#get_all_posts"
  get  "/posts/:user_id",           to: "posts#get_posts"
  get  "/post/:post_id",      to: "posts#get_post_by_id"
  post "/post",               to: "posts#create_post"
  post "/post/:post_id/comment", to: "posts#create_comment"
  delete "/post/:post_id/comment/:comment_id", to:"posts#delete_comment" 

  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  get "up" => "rails/health#show", as: :rails_health_check
end

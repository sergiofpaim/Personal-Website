Rails.application.routes.draw do
  resources :users

  get  "/posts",               to: "posts#get_all_posts"
  get  "/posts/:user_id",           to: "posts#get_posts"
  post "/posts",               to: "posts#create_post"
  post "/posts/:post_id/comments", to: "posts#create_comment"

  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  get "up" => "rails/health#show", as: :rails_health_check
end

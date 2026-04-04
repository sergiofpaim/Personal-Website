Rails.application.routes.draw do
  resources :users

  # Auth
  post  "/register",                              to: "auth#register"
  post  "/login",                                 to: "auth#login"
  delete "/logout",                               to: "auth#logout"

  # Posts
  get  "/posts",                                  to: "posts#get_all_posts"
  get  "/my/posts",                               to: "posts#get_my_posts"
  get  "/posts/:user_id",                         to: "posts#get_posts"
  get  "/post/:post_id",                          to: "posts#get_post_by_id"
  post "/post",                                   to: "posts#create_post"
  post "/post/:post_id/comment",                  to: "posts#create_comment"
  put "/my/post/:post_id",                        to: "posts#edit_my_post"
  delete "/my/post/:post_id",                     to: "posts#delete_my_post"
  delete "/post/:post_id/my/comment/:comment_id", to: "posts#delete_my_comment"

  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  get "up" => "rails/health#show", as: :rails_health_check
end

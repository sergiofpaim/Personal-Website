Rails.application.routes.draw do
  # Auth
  post  "/register",                              to: "auth#register"
  post  "/login",                                 to: "auth#login"
  delete "/logout",                               to: "auth#logout"

  # User
  get  "/users",                                  to: "users#get_all_user_profiles"
  get  "/users/:nickname/profile",                to: "users#get_user_profile"
  get "/me",                                      to: "users#get_me"
  put "/me",                                      to: "users#update_me"
  delete "/me",                                   to: "users#destroy_me"
  # User - Admin
  post "/user",                                   to: "users#create_user"
  put "/users/:nickname",                         to: "users#set_as_admin"
  delete "users/:nickname",                       to: "users#destroy_user"

  # Posts
  get  "/posts",                                  to: "posts#get_all_posts"
  get  "/post/:post_id",                          to: "posts#get_post_by_id"
  get  "/my/posts",                               to: "posts#get_my_posts"
  post "/my/post",                                to: "posts#create_my_post"
  post "/post/:post_id/my/comment",               to: "posts#create_my_comment"
  put "/my/post/:post_id",                        to: "posts#edit_my_post"
  delete "/my/post/:post_id",                     to: "posts#delete_my_post"
  delete "/post/:post_id/my/comment/:comment_id", to: "posts#delete_my_comment"
  # Posts - Admin
  delete "/post/:post_id",                        to: "posts#delete_post"
  delete "post/:post_id/comment/:comment_id",                  to: "posts#delete_comment"


  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  get "up" => "rails/health#show", as: :rails_health_check
end

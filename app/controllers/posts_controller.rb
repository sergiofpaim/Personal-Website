class PostsController < ApplicationController
  before_action do
    @service = PostService.new
  end

  before_action :require_admin, only: [ :delete_post, :delete_comment ]
  before_action :require_author, only: [ :create_my_post, :edit_my_post, :delete_my_post ]

  # Gets all posts
  def get_all_posts
    posts = @service.get_all_posts

    render json: posts
  end

  # Gets all my posts
  def get_my_posts
    posts = @service.get_posts(current_user.id)

    render json: posts
  end

  # Gets a post
  def get_post_by_id
    post = @service.get_post_by_id(post_id_param)

    render json: post
  end

  # Creates a post
  def create_my_post
    post = @service.create_post(create_post_params.merge(user_id: current_user.id))

    render json: post
  end

  # Creates a comment in a post
  def create_my_comment
    comment = @service.create_comment(post_id_param, comment_params.merge(user_id: current_user.id))

    render json: comment
  end

  # Edits my post
  def edit_my_post
    post = @service.edit_post(post_id_param, edit_post_params.merge(user_id: current_user.id))

    render json: post
  end

  # Deletes my post
  def delete_my_post
    result = @service.delete_my_post(post_id_param, current_user)

    render json: result
  end

  # Deletes my comment
  def delete_my_comment
    result = @service.delete_my_comment(post_id_param, comment_id_param, current_user)

    render json: result
  end

  # ADMIN

  # Deletes a post
  def delete_post
    result = @service.delete_post(post_id_param)

    render json: result
  end

  # Deletes a comment
  def delete_comment
    result = @service.delete_comment(post_id_param, comment_id_param)

    render json: result
  end

  private

  # Body params
  def create_post_params
    post = params.require(:post)

    post.require(:title)
    post.require(:content)

    post.permit(:title, :content, :tag, :overview)
  end

  def edit_post_params
    params.require(:post).permit(:tag, :title, :overview, :content)
  end

  def comment_params
    comment = params.require(:comment)
    comment.require(:content)

    comment.permit(:content)
  end

  # Route/query params
  def user_id_param
    params.require(:user_id)
  end

  def post_id_param
    params.require(:post_id)
  end

  def comment_id_param
    params.require(:comment_id)
  end

  def require_admin
    render json: { error: "Access denied" }, status: :forbidden unless current_user.role.include?("admin")
  end

  def require_author
    render json: { error: "Access denied" }, status: :forbidden unless current_user.role.include?("author")
  end
end

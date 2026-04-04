class PostsController < ApplicationController
  before_action do
    authenticate_request
    @service = PostService.new
  end

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

  # Gets a specific user's posts
  def get_posts
    posts = @service.get_posts(user_id_param)

    render json: posts
  end

  # Gets a post
  def get_post_by_id
    post = @service.get_post_by_id(post_id_param)

    render json: post
  end

  # Creates a post
  def create_post
    unless current_user.role.include?("author")
      render json: { error: "Acesso negado" }, status: :forbidden
      return
    end

    post = @service.create_post(create_post_params.merge(user_id: current_user.id))

    render json: post
  end

  # Creates a comment in a post
  def create_comment
    comment = @service.create_comment(post_id_param, comment_params.merge(user_id: current_user.id))

    render json: comment
  end

  # Edits my post
  def edit_my_post
    unless current_user.role.include?("author")
      render json: { error: "Acesso negado" }, status: :forbidden
      return
    end

    post = @service.edit_post(post_id_param, edit_post_params.merge(user_id: current_user.id))

    render json: post
  end

  # Deletes my post
  def delete_my_post
    unless current_user.role.include?("author")
      render json: { error: "Acesso negado" }, status: :forbidden
      return
    end

    result = @service.delete_my_post(post_id_param, current_user)

    render json: result
  end

  # Deletes my comment
  def delete_my_comment
    result = @service.delete_my_comment(post_id_param, comment_id_param, current_user)

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
end

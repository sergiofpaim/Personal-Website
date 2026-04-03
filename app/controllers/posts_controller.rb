class PostsController < ApplicationController
  before_action do
    authenticate_request
    @service = PostService.new
  end

  # Gets all posts
  def get_all_posts
    posts = @service.get_all_posts()

    render json: posts
  end

  # Gets all posts for a specific user
  def get_posts
    posts = @service.get_posts(params[:user_id])

    render json: posts
  end

  # Gets a post
  def get_post_by_id
    post = @service.get_post_by_id(params[:post_id])

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
    comment = @service.create_comment(params[:post_id], comment_params.merge(user_id: current_user.id))

    render json: comment
  end

  # Edits um post
  def edit_my_post
    unless current_user.role.include?("author")
        render json: { error: "Acesso negado" }, status: :forbidden
        return
    end

    post = @service.edit_post(params[:post_id], edit_post_params.merge(user_id: current_user.id))

    render json: post
  end

  # Deletes a post
  def delete_my_post
    unless current_user.role.include?("author")
        render json: { error: "Acesso negado" }, status: :forbidden
        return
    end

    result = @service.delete_my_post(params[:post_id], current_user)

    render json: result
  end

  # Deletes a comment
  def delete_my_comment
    result = @service.delete_my_comment(params[:post_id], params[:comment_id], current_user)

    render json: result
  end

  # Request Params
  private
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
      params.require(:comment).permit(:content)
    end
end

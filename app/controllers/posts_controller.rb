class PostsController < ApplicationController
  before_action do
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
    post = @service.create_post(create_post_params)

    render json: post
  end

  # Creates a comment in a post
  def create_comment
    comment = @service.create_comment(params[:post_id], comment_params)

    render json: comment
  end

  # Edits um post
  def edit_post
    post = @service.edit_post(params[:post_id], edit_post_params)

    render json: post
  end

  # Deletes a post
  def delete_post
    result = @service.delete_post(params[:post_id])

    render json: result
  end

  # Deletes a comment
  def delete_comment
    result = @service.delete_comment(params[:post_id], params[:comment_id])

    render json: result
  end

  # Request Params
  private
    def create_post_params
      post = params.require(:post)

      post.require(:title)
      post.require(:content)

      post.permit(:title, :content, :tag, :overview, :user_id)
    end

    def edit_post_params
      params.require(:post).permit(:tag, :title, :overview, :content, :user_id)
    end

    def comment_params
      params.require(:comment).permit(:content, :user_id)
    end
end

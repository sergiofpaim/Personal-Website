class PostsController < ApplicationController
  # Gets all posts
  def get_all_posts
    posts = PostService.get_all_posts()

    render json: posts
  end

  # Gets all user's posts
  def get_posts
    posts = PostService.get_posts(params[:user_id])

    render json: posts
  end

  # Gets a post
  def get_post_by_id
    post = PostService.get_post_by_id(params[:post_id])

    render json: post
  end

  # Creates a post
  def create_post
    post = PostService.create_post(create_post_params)

    render json: post
  end

  # Creates a comment in a post
  def create_comment
    comment = PostService.create_comment(params[:post_id], comment_params)

    render json: comment
  end

  # Edits um post
  def edit_post
    post = PostService.edit_post(params[:post_id], edit_post_params)

    render json: post
  end

  # Deletes a post
  def delete_post
    result = PostService.delete_post(params[:post_id])

    render json: result
  end

  # Deletes a comment
  def delete_comment
    result = PostService.delete_comment(params[:post_id], params[:comment_id])

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

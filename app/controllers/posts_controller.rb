class PostsController < ApplicationController
  # GET /posts
  def get_posts
    posts = PostService.get_posts()

    render json: posts, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  # GET /posts/{post_id}
  def show_post
    posts = PostService.get_posts(params[:id])

    render json: posts, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity  end

  # POST /posts
  def create_post
    post = PostService.create_post(post_params)

    render json: post, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  # POST /posts/post_id/comments
  def create_comment
    comment = PostService.create_comment(params[:post_id], comment_params)

    render json: comment, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  private
    def post_params
      params.expect(post: [ :tag, :title, :overview, :content, :user_id ])
    end

    def comment_params
      params.expect(comment: [ :content, :user_id ])
    end
end

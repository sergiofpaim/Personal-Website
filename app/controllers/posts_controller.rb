class PostsController < ApplicationController
  # GET /posts
  def index
    posts = PostService.get_posts()

    render json: posts, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  # GET /posts/1
  def show
    posts = PostService.get_posts(params[:id])

    render json: posts, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity  end

  # POST /posts
  def create
    post = PostService.create_post(post_params)

    render json: post, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  private
    def post_params
      params.expect(post: [ :tag, :title, :overview, :content, :user_id ])
    end
end

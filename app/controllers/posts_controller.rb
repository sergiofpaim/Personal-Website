class PostsController < ApplicationController
  # GET /posts
  # Busca todos os posts
  def get_all_posts
    posts = PostService.get_all_posts()

    render json: posts, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  # GET /posts/{user_id}
  # Busca os posts de um usuário específico
  def get_posts
    posts = PostService.get_posts(params[:user_id])

    render json: posts, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity 
  end

  # GET /post/{post_id}
  # Retorna um post
  def get_post_by_id
    post = PostService.get_post_by_id(params[:post_id])

    render json: post
  end

  # POST /post
  # Cria um post
  def create_post
    post = PostService.create_post(post_params)

    render json: post, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  # POST /post/{post_id}/comments
  # Cria um comentário em um post
  def create_comment
    comment = PostService.create_comment(params[:post_id], comment_params)

    render json: comment, status: :created

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      errors: e.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  # DELETE /post/{post_id}
  # Deleta um post
  def delete_post
    PostService.delete_post(params[:post_id])
  end

  # DELETE /post/{post_id}/comment/{comment_id}
  # Deleta um comentario e o remove do post
  def delete_comment
    result = PostService.delete_comment(params[:post_id], params[:comment_id])

    render json: result
  end

  # Request Params
  private
    def post_params
      params.expect(post: [ :tag, :title, :overview, :content, :user_id ])
    end

    def comment_params
      params.expect(comment: [ :content, :user_id ])
    end
end

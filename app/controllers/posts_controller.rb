class PostsController < ApplicationController
  before_action :require_login

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
  end

  def new
    @post = Post.new
  end


  def create
    @post = Post.new(post_params)
    @post.user = current_user 

    if @post.save
      redirect_to @post, notice: "Post foi criado com sucesso."
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    if current_user != @post.user
      redirect_to posts_path, alert: "Você não tem permissão para editar este post."
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: "Post atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.comments.destroy_all
      @post.destroy
      redirect_to posts_path, notice: "Post excluído com sucesso."
    else
      redirect_to posts_path, alert: "Você não tem permissão para excluir este post."
    end
  end


  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end

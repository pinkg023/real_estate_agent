class PostsController < ApplicationController

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
    @post = Post.find(params[:id])
    @images = @post.images
  end

end

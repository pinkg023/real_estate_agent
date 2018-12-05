class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_post, :only => [:show, :edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(20)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = '發布公告！'
      redirect_to post_path(@post)       
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      redirect_to root_path
    end
  end

  def destroy
    @post.destroy
    if @post.present?
      flash[:alert] = @post.errors.full_messages.to_sentence
    else
      flash[:alert] = "公告已刪除！" 
    end
      redirect_to admin_root_path
  end

  def update
      if @post.update(post_params)
        flash[:notice] = "公告已更新！"           
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
      end
      redirect_to post_path(@post) 
  end

  def show
  end

  def edit
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
    def post_params
      params.require(:post).permit( :title, :description)
    end
end

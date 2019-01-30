class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_post, :only => [:show, :edit, :update, :clearfile]

  def index
    @post = Post.new
    @posts = Post.order(created_at: :desc).page(params[:page]).per(20)
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = '發布公告！'
      redirect_to edit_admin_post_path(@post)   
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      redirect_to admin_root_path
    end
  end

  def destroy  
    set_post  
    @post.destroy
    if Post.exists?(id: @post.id)
      flash[:alert] = @post.errors.full_messages.to_sentence + @post.title
    else
      flash[:notice] = "公告已刪除！" 
    end
      redirect_to admin_root_path
  end

  def update
      if @post.update(post_params)
        flash[:notice] = "公告已更新！"           
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
      end
      redirect_to edit_admin_post_path(@post)
  end

  def show
    @posts = Post.order(created_at: :desc).page(params[:page]).per(20)
  end

  def edit
    @posts = Post.order(created_at: :desc).page(params[:page]).per(20)
  end

  def clearfile
    @post.images.purge
    @post.documents.purge
    redirect_to edit_admin_post_path(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
    def post_params
      params.require(:post).permit(:title, :description, images: [], documents: [])
    end

end

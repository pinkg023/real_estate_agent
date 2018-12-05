class Admin::PostsController < ApplicationController
  before_action :authenticate_admin

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(50)
  end
end

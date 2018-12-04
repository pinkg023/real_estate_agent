class PagesController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc).limit(4)
  end
end

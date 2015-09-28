class PostController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
  end

  def new
    @category = Category.find(params[:category_id])
    @category.posts.build
  end

  def show
    @post = Post.where(category_id: params[:category_id], id: params[:id])
  end
end

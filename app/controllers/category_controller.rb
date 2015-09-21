class CategoryController < ApplicationController
  def posts
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.find(params[:id])
    @post = Post.new(category: @category)
  end
end

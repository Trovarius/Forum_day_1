class CategoryController < ApplicationController
  def posts
    @category = Category.find(params[:id])

  end
end

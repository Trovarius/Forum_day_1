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

  def create
    @category = Category.find(params[:category_id])
    @post = @category.posts.build(post_params)
    if @post.save
      redirect_to category_post_path(@post.category, @post)
    else
      render 'new'
    end
  end

  def edit
    @post = Post.where(category_id: params[:category_id], id: params[:id]).first
  end

  def update
    @post = Post.where(category_id: params[:category_id], id: params[:id]).first

    @post.update_attributes!(post_params)
  end

  private
  def post_params
    if @post 
      params.require(:post).permit(:title)
    else
      params.require(:post).permit(:title, comments_attributes: [:description])
    end
  end
end

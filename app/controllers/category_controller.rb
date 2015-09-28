class CategoryController < ApplicationController
  def posts
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.find(params[:id])
    @post = Post.new(category: @category)
  end
  
  def create
    @category = Category.find(params[:id])
    @post  = Post.new(post_params)
    @post.category = @category
    @post.save
    if @post.save
      redirect_to show_post_path(@category, @post)
    else
      render 'new'
    end

  end

  def show
    @post = Post.find(params[:post_id])
  end

  def edit
    @category = Category.find(params[:id])
    @post = @category.find(params[:post_id])
  end

  def update
    @category = Category.find(params[:id])
    @post = @category.posts.find(params[:post_id])
    if @post.update(post_params) 
      redirect_to post_path(@category, @post)
    else
      render :edit
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, comments_attributes:[:description])
  end


end

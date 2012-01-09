class PostsController < ApplicationController

 http_basic_authenticate_with :name => "zhangda", :password => "sashiko"

  def show
    @post = Post.find(params[:id])
  end
    
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:success] = "new post added"
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.paginate :page => params[:page], 
                           :order => 'created_at DESC',
                           :per_page => 5
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:success] = "post updated"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    flash[:success] = "post deleted"
    redirect_to posts_path
  end


end


class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @author = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @author = User.find(params[:user_id])
  end

  def new; end

  def create 
    title = params[:title]
    text = params[:text]
    post = Post.new(author:current_user, title:title, text:text)
  
    if post.save
      post.update_posts_counter
      redirect_to user_posts_path, notice: "Post created successfully!!"
    else
      flash.now[:alert] = "Unable to create a post"
      render :new
    end
  end
end

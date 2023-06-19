class PostsController < ApplicationController
    def index
      @author = User.find(params[:user_id])
      @posts = @author.posts.includes(:comments)
  end

  def show
    @author = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end

  def create
    title = params[:post][:title]
    text = params[:post][:text]
    post = Post.new(author: current_user, title:, text:)

    if post.save
      post.update_posts_counter
      redirect_to user_posts_path, notice: 'Post created successfully!!'
    else
      flash.now[:alert] = 'Unable to create a post'
      render :new
    end
  end
end

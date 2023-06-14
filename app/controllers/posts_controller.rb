class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @author = User.find(params[:user_id])
  end

  def show 
    @post = Post.find(params[:id])
    @author = User.find(params[:user_id])
  end
end

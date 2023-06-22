class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    text = params[:comment][:text]
    post = Post.find(params[:post_id])
    comment = Comment.new(post:, author: current_user, text:)

    if comment.save
      comment.update_comments_counter
      redirect_to user_post_path(id: post.id), notice: 'Comment added successfully!!'
    else
      flash.now[:alert] = 'Unable to add a comment'
      render :new
    end
  end

  def destroy
     comment = Comment.find(params[:id])
     comment.destroy
    redirect_to user_post_path(params[:post_id]), notice: 'Comment deleted successfully!!'
  end
end

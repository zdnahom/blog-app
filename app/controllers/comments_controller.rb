class CommentsController < ApplicationController
  def new; end

  def create 
    text = params[:text]
    post = Post.find(params[:post_id])
    comment = Comment.new(post:post, author:current_user, text:text)
  
    if comment.save
      comment.update_comments_counter
      redirect_to user_post_path(id: post.id), notice: "Comment added successfully!!"
    else
      flash.now[:alert] = "Unable to add a comment"
      render :new
    end
  end
end

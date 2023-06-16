class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    like = Like.create(post: post, author: current_user)
    like.update_likes_counter
    redirect_to user_post_path(id: post.id)
  end
end

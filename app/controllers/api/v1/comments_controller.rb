class Api::V1::CommentsController < ApplicationController
    def index
        @comments = Post.find(params[:post_id]).comments.all
        render json: @comments
    end
end
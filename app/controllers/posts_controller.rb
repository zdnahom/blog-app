class PostsController < ApplicationController
    def index
        render 'pages/posts'
    end
    def show
        render 'pages/post_detail'
    end
end
class UsersController < ApplicationController
    def index
        render 'pages/index'
    end
    def show
        render 'pages/detail'
    end
end
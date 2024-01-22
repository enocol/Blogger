class UsersController < ApplicationController
    before_action :set_user, only: [:show]
    before_action :set_user, only: [:show, :posts]
    #before_action :set_post, only: [:post_detail]
    before_action :set_post, only: [:show_user_post]

    def index
        @users = User.all
    end

    def show
        @user = User.find_by(id: params[:id])

        if @user.nil?
            redirect_to users_path
            return
        end
    end

    def posts
        @user_posts = @user.posts
    end

    def show_user_post
        
    end

    private

    def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = 'User not found'
        redirect_to users_path
    end

    def set_post
        if @user.nil?
          flash[:error] = 'User not found'
          # redirect_to user_path
          @user = nil

        else
          @post = @user.posts.find_by(id: params[:post_id])
    
          if @post.nil?
            flash[:error] = 'Post not found'
            #redirect_to user_posts_path(@user)
            @post = nil
          end
        end
    end
end

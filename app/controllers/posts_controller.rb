class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:community_id].present? && params[:community_id] != ""
      @community = Community.find_by(id: params[:community_id])

      if @community
        @posts = @community.posts.order(created_at: :desc)
      else
        flash[:alert] = "Community not found"
        redirect_to posts_path
      end
    else
      # render all
      @posts = Post.order(created_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
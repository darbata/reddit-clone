class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @community = Community.find(params[:community_id])
    @post = @community.posts.new
  end

  def create
    @community = Community.find(params[:community_id])
    @post = @community.posts.new
  end

  def create
    @community = Community.find(params[:community_id])
    @post = @community.posts.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post created successfully"
      redirect_to post_path(@post)
    else
      flash.new[:alert] = "Error posting your post"
      render :new
    end
  end

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

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
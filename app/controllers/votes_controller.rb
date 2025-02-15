class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post

  def upvote
    unless current_user.voted_up_on?(@post)
      @post.liked_by current_user
    else
      @post.unliked_by current_user
    end
    @post.reload
    redirect_back fallback_location: post_path(@post)
  end

  def downvote
    unless current_user.voted_down_on?(@post)
      @post.disliked_by current_user
    else
      @post.undisliked_by current_user
    end
    @post.reload
    redirect_back fallback_location: post_path(@post)
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end
end

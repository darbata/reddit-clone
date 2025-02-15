class FollowController < ApplicationController
  before_action :authenticate_user!

  def create
    followed_user = User.find(params[:followed_id])
    follow = current_user.following_relationships.build(followed: followed_user)

    if follow.save
      flash[:notice] = "You are now following #{followed_user.username}"
    else
      flash[:alert] = "Unable to follow user."
    end
    redirect_back(fallback_location: root_path) 
  end

  def destroy
    follow = Follow.find_by(follower: current_user, followed_id: params[:id])
    follow.destroy if follow
    flash[:notice] = "Unfollowed succesffuly."
    redirect_back(fallback_location: root_path)
  end
end
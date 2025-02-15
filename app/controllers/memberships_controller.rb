class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_community
  before_action :find_membership, only: [:destroy, :update]

  def create
    @membership = current_user.memberships.new(community: @community, role: "Member")
    if @membership.save
      flash[:notice] = "You have successfully joined #{@community.name} as a Member"
    else
      flash[:alert] = "Unable to join community"
    end
    redirect_back fallback_location: community_path(@community)
  end

  def destroy
    if @membership
      @membership.destroy
      flash[:notice] = "You have left #{@community.name}"
    else
      flash[:alert] = "Membership not found"
    end
    redirect_back fallback_location: community_path(@community)
  end

  def update
    new_role = parms[:role] # to be passed Moderator or Member
    if @membership.update(role: new_role)
      flash[:notice] = "Membership role updated to #{new_role}"
    else
      flash[:alert] = "Unable to update role"
    end
    redirect_back fallback_location: community_path(@community)
  end

  private

  def find_community
    @community = Community.find(params[:community_id])
  end

  def find_membership
    @membership = current_user.memberships.find_by(community: @community)
  end
end

class CommunitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @communites = Community.all.order(:name)
  end

  def show
    @community = Community.find(params[:id])
    @posts = @community.posts.order(create_at: :desc)
  end
end

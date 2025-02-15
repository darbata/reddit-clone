class UsersController < ApplicationController
  def show
    @user = if params[:username]
              User.find_by(username: params[:username])
            else
              current_user
            end

    unless @user
      flash[:alert] = "User not found."
      redirect_to root_path
    end
  end
end
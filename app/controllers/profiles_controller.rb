class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show
    @notifications = @user.notifications
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
    authorize @user
  end

  def user_params
    params.require(:user).permit(:email, :profile_picture)
  end
end

class ProfilesController < ApplicationController
  before_action :set_user

  def show
    @notifications = @user.notifications
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @user = current_user
    authorize @user
  end
end

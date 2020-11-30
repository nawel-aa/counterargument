class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show
    @arguments = @user.arguments.order(created_at: :desc)

    # Count the number of arguments that are children to other arguments
    @counterarguments_count = 0
    @arguments.each do |argument|
      @counterarguments_count += argument.relationships_as_a_child.count
    end

    # Count the number of arguments that don't have a parent
    @arguments_count = 0
    @arguments.each do |argument|
      @arguments_count += 1 if argument.parents.empty?
    end
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

class ProfilesController < ApplicationController
  before_action :set_user

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
  end

  private

  def set_user
    @user = current_user
    authorize @user
  end
end

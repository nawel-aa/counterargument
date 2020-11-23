class ArgumentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]

  def new
  end

  def create
    @argument = Argument.new
    @argument.user = current_user
    authorize @argument
  end

  def show
  end

  def edit

  end

  def update
    @argument = Argument.find(params[:id])
    authorize @argument
  end
end

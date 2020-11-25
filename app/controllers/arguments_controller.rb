class ArgumentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]

  def new
    @argument = Argument.new
    authorize @argument
  end

  def create
    @argument = Argument.new(argument_params)
    @argument.user = current_user
    authorize @argument

    parent_id = params[:argument][:argument_id]

    add_parent(parent_id) if parent_id

    if @argument.save
      if parent_id
        create_notification(parent_id)
        redirect_to argument_path(Argument.find(parent_id))
      else
        redirect_to argument_path(@argument)
      end
    else
      @argument_show = Argument.find(params[:argument][:argument_id])
      render "/arguments/show"
    end
  end

  def show
    @argument = Argument.new
    @argument_show = Argument.find(params[:id])
    authorize @argument_show
  end

  def edit

  end

  def update
    @argument = Argument.find(params[:id])
    authorize @argument
  end

  private

  def argument_params
    params.require(:argument).permit(:content, :source, :argument_id, :hidden)
  end

  def add_parent(parent_id)
    parent = Argument.find(parent_id)
    @argument.parents << parent
  end

  def create_notification(parent_id)
    notification = Notification.new
    argument_countered = Argument.find(parent_id)
    notification.argument = argument_countered
    notification.message = "#{current_user.nickname} submitted a new counterargument to \"#{argument_countered.content}\""
    notification.user = argument_countered.user
    notification.save
  end
end

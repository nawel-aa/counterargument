class ArgumentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]

  def new
    @argument = Argument.new
    authorize @argument
  end

  def create
    @argument = Argument.new(content: argument_params[:content], source: argument_params[:source], hidden: argument_params[:hidden])
    @argument.user = current_user
    authorize @argument

    parent = Argument.find(argument_params[:parent_id]) if argument_params[:parent_id]

    if @argument.save
      if parent
        ArgumentParentChildRelationship.create(parent: parent, child: @argument)
        create_notification(parent)
        redirect_to argument_path(parent)
      else
        redirect_to argument_path(@argument)
      end
    else
      @argument_show = parent
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
    params.require(:argument).permit(:content, :source, :hidden, :parent_id)
  end

  def create_notification(parent)
    notification = Notification.new
    argument_countered = parent
    notification.argument = argument_countered
    notification.message = "#{current_user.nickname} submitted a new counterargument to \"#{argument_countered.content}\""
    notification.user = argument_countered.user
    notification.save
  end
end

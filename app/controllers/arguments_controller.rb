class ArgumentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]

  def index
    @arguments = Argument.all
  end

  def new
    @argument = Argument.new
    authorize @argument
  end

  def create
    @argument = Argument.new(argument_params)
    @argument.user = current_user
    authorize @argument
    if @argument.save
      if params[:argument][:argument_id]
        redirect_to argument_path(Argument.find(params[:argument][:argument_id]))
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
    # @results = index.search(params[:query])[0]
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
end

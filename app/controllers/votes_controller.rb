class VotesController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @vote = Vote.new(vote_params)
    @vote.user = current_user
    @vote.positive = true
    # raise
    authorize @vote
    if @vote.save
      @argument_show = Argument.find(params[:origin])
      redirect_to argument_path(@argument_show)
    else
      @argument_show = Argument.find(params[:argument_id])
      render "/arguments/show"
    end
  end

  private

  def vote_params
    params.permit(:argument_id, :category)
  end
end

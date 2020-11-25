class VotesController < ApplicationController
  skip_before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def create
    @vote = Vote.new(vote_params)
    @vote.user = current_user
    @vote.positive = true
    # raise
    authorize @vote
    @vote.save
    @argument_show = Argument.find(params[:origin])
    redirect_to argument_path(@argument_show, anchor: "arg-#{params[:argument_id]}")
    # @results = index.search(params[:query])[0]
    # render "/arguments/show"
  end

  private

  def vote_params
    params.permit(:argument_id, :category)
  end

  def user_not_authorized
    alert = current_user.nil? ? "You ust be logged in to upvote a post" : "You cannont upvote your own post"
    flash[:alert] = alert
    redirect_to(request.referrer || root_path)
  end
end

class VotesController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    vote = Vote.new(vote_params)
    vote.user = current_user
    vote.positive = true

    authorize vote
    if vote.save
      @argument_show = Argument.find(params[:origin])

      # Create upvote notification
      create_notification

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

  def create_notification
    notification = Notification.new
    upvoted_argument = Argument.find(params[:argument_id])
    notification.argument = upvoted_argument
    notification.message = "#{current_user.nickname} upvoted \"#{upvoted_argument.content}\""
    notification.user = upvoted_argument.user
    notification.save
  end
end

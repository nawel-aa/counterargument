class VotesController < ApplicationController
  skip_before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def create
    vote = Vote.new(vote_params)
    vote.user = current_user
    vote.positive = true

    argument = Argument.find(params[:argument_id])
    vote_user_category = {}
    x = 0
    argument.votes.each do |vote|
      x += 1
      vote_user_category[x] = vote.category
    end
    authorize vote
    if vote_user_category.has_value?(vote_params[:category])
      alert = "You cannont upvote a post multiple times in the same category"
      flash[:alert] = alert
      redirect_to(request.referrer || root_path)
    else
      vote.save

      # Create upvote notification
      create_notification

      @argument_show = Argument.find(params[:origin])
      redirect_to argument_path(@argument_show, anchor: "arg-#{params[:argument_id]}")
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

    NotificationsChannel.broadcast_to(
      notification.user,
      notification.user.notifications.where(read: false).count
    )
  end

  def user_not_authorized
    alert = current_user.nil? ? "You must be logged in to upvote a post" : "You cannont upvote your own post"
    flash[:alert] = alert
    redirect_to(request.referrer || root_path)
  end
end

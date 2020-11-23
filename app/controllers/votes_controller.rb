class VotesController < ApplicationController
  def create
    @vote = Vote.new
    @vote.user = current_user
    authorize @vote
    # @vote.argument = 
  end
end

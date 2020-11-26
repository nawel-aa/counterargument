class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home search]

  def home
    @arguments = policy_scope(Argument).order(created_at: :desc)
  end

  def search
    if params[:search_form].nil? || params[:search_form][:results] == ""
      @arguments = Argument.all.order(created_at: :desc)
    elsif params[:search_form][:results] == "[]"
      return
    else
      parse_results
      
      # FILTERS
      # For each topic, search for the matches with @arguments
      # Send this back to the view
      # Take into account the tag param for displaying the results
    end
  end

  private

  def parse_results
    arguments_ids = JSON.parse(params[:search_form][:results])

    @arguments =
      arguments_ids
      .map { |id| Argument.find(id) }
      .sort! { |a, b| a.created_at <=> b.created_at }
  end
end

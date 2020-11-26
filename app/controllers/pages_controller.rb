class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home search]

  def home
    @arguments = policy_scope(Argument).order(created_at: :desc)
  end

  def search
    # If no params are passed, display all arguments
    if params[:search_results].nil? || params[:search_results][:results_ids] == ""
      @arguments = Argument.includes(:tags).order(created_at: :desc)

    # If no results are returned by the search, return to the view
    elsif params[:search_results][:results_ids] == "[]"
      return

    # Else create @arguments with the ids passed by Algolia's JSON
    else
      @results = search_results_params
      parse_results
    end

    # Apply filters if there are some
    filter_results if params[:tag]
    # Generate filters list
    generate_filter_list
  end

  private

  def search_results_params
    params.require("search_results").permit(:results_ids)
  end

  def parse_results
    results_ids = JSON.parse(@results[:results_ids])

    @arguments =
      results_ids
      .map { |id| Argument.find(id) }
      .sort! { |a, b| a.created_at <=> b.created_at }
  end

  def filter_results
    @selected_tag = Tag.find_by(name: params[:tag])

    # Select only arguments that are tagged with the selected tag
    @arguments = @arguments.select { |argument| argument.tags.include?(@selected_tag) }
  end

  def generate_filter_list
    # Will be a hash of tag_name: counter
    @tags = {}

    @arguments.each do |argument|
      # For each argument, get its tags
      # For each tag, add 1 to its counter
      argument.tags.each do |tag|
        if @tags[tag.name.to_sym].nil?
          @tags[tag.name.to_sym] = 1
        else
          @tags[tag.name.to_sym] += 1
        end
      end
    end
  end
end

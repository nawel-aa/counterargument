class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home search]

  def home
    @arguments = policy_scope(Argument).order(created_at: :desc)
    @trending = @arguments.map do |argument|
      [argument.children.count, argument]
    end
    @trending.sort!.reverse!
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
      @results = search_results_params[:results_ids]
      parse_results
    end

    # Apply filters if there are some
    filter_results if search_results_params[:tag]
    # Generate filters list
    generate_filter_list
  end

  private

  def search_results_params
    params.require("search_results").permit(:results_ids, :tag)
  end

  def parse_results
    results_ids = JSON.parse(@results)

    @arguments =
      results_ids
      .map { |id| Argument.find(id) }
      .sort! { |a, b| a.created_at <=> b.created_at }
  end

  def filter_results
    # Split the tags in an array
    @selected_tags = search_results_params[:tag].split('|')
    @selected_tags.map! do |tag|
      Tag.find_by(name: tag)
    end

    # Select only arguments that are tagged with the selected tags
    @selected_tags.each do |tag|
      @arguments = @arguments.select { |argument| argument.tags.include?(tag) }
    end
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

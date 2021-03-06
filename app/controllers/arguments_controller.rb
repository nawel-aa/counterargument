class ArgumentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]

  def index
    @arguments = Argument.all
  end

  def new
    @argument = Argument.new
    @tags = Tag.all.map { |tag| tag.name }.sort
    authorize @argument
  end

  def create
    if params[:argument][:argument_id]
      @argument = Argument.find(params[:argument][:argument_id].to_i)
      parent = Argument.find(params[:argument][:parent_id].to_i)
      # counter.children << ["parent_id", params[:argument][:parent_id].to_i]
      authorize @argument
      @argument.save
      ArgumentParentChildRelationship.create(parent: parent, child: @argument)
      create_notification(parent)
      redirect_to argument_path(parent)
    else
      @argument = Argument.new(content: argument_params[:content], source: argument_params[:source], hidden: argument_params[:hidden] == "1")
      @argument.user = current_user
      if params[:argument][:tag_ids]
        @tags = params[:argument][:tag_ids]
        @tags.each { |tag_id| @argument.tags << Tag.find(tag_id.to_i) }
      end
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
  end

  def show
    @argument = Argument.new
    @argument_show = Argument.find(params[:id])
    authorize @argument_show
    @child = @argument_show.children.map do |counterargument|
      [counterargument, Vote.source(counterargument.id), Vote.funny(counterargument.id), Vote.concise(counterargument.id)]
    end

    @source_count = Vote.source

    @tag = Tag.new
    @tags = Tag.all.map { |tag| tag.name }.sort
    # @results = index.search(params[:query])[0]

    @related_arguments = @argument_show.parents.first(5)
  end

  def edit
  end

  def update
    @argument = Argument.find(params[:id])
    @argument.hidden ? @argument.hidden = false : @argument.hidden = true
    authorize @argument
    @argument.save
    redirect_to profile_path(current_user, anchor: "anchor-#{@argument.id}")
  end

  private

  def argument_params
    params.require(:argument).permit(:content, :source, :hidden, :parent_id, :tag_ids)
  end

  def create_notification(parent)
    notification = Notification.new
    argument_countered = parent
    notification.argument = argument_countered
    notification.message = "#{current_user.nickname} submitted a new counterargument to \"#{argument_countered.content}\""
    notification.user = argument_countered.user
    notification.save

    NotificationsChannel.broadcast_to(
      notification.user,
      notification.user.notifications.where(read: false).count
    )
  end
end

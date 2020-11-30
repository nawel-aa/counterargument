class TagsController < ApplicationController
  skip_before_action :authenticate_user!
  def create
    @argument_show = Argument.find(params[:id])
    @tag = Tag.new(tag_params)
    @tag.save
    authorize @tag
    render "/arguments/show"
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end

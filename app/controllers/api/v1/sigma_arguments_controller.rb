class Api::V1::SigmaArgumentsController < Api::V1::BaseController
  def index
    @arguments = Argument.all
    @relationships = ArgumentParentChildRelationship.all
  end
end

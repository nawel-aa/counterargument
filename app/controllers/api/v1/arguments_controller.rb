class Api::V1::ArgumentsController < Api::V1::BaseController
  def index
    @arguments = policy_scope(Argument)
  end
end

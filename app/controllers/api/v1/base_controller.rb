class Api::V1::BaseController < ActionController::API
  include Pundit # we are protecting all of our controllers inside the api
  # these two after action checks if pundit was actually used
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # the 500 error page is HTML but we want to use json so in the event
  # that something breaks we are rendering json
  rescue_from Pundit::NotAuthorizedError,   with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def user_not_authorized(exception)
    render json: {
      error: "Unauthorized #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}"
    }, status: :unauthorized
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end

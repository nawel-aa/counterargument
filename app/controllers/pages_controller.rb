class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home search]

  def home
    @arguments = policy_scope(Argument).order(created_at: :desc)
  end

  def search
    @arguments = policy_scope(Argument).order(created_at: :desc)
  end
end

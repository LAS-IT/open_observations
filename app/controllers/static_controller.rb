class StaticController < ApplicationController
  before_filter :redirect_logged_in_users

  # http://stackoverflow.com/questions/18557977/how-to-fix-a-missing-template-error
  def index
    render "static/index"
  end

  private
  def redirect_logged_in_users
    redirect_to dashboard_url if user_signed_in?
    # http://stackoverflow.com/questions/18557977/how-to-fix-a-missing-template-error
    render "static/index" unless user_signed_in?
  end
end

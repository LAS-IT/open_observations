class DashboardController < ProlearningController
  def index
    @user = current_user.decorate
  end
end

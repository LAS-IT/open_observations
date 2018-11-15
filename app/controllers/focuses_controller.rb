class FocusesController < ProlearningController
  load_and_authorize_resource through: :school, find_by: :uuid

  def new
    @focus = current_user.school.focuses.build
  end

end

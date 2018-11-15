class ProgramsController < ProlearningController
  load_and_authorize_resource through: :school, find_by: :uuid

  def new
    @program = current_user.school.programs.build
  end

end

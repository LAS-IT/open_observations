class DepartmentsController < ProlearningController
  load_and_authorize_resource :program, through: :school, find_by: :uuid
  load_and_authorize_resource through: :program, shallow: true, find_by: :uuid

  before_filter :load_new_path, only: [:index]

  private
  def load_new_path
    @new_path = @program.present? ? new_program_department_path(@program) : new_department_path
  end

end

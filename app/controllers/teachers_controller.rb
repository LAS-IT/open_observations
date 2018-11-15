class TeachersController < ProlearningController
  load_and_authorize_resource through: :school, find_by: :uuid
end

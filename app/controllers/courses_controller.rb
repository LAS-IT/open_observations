class CoursesController < ProlearningController
  load_and_authorize_resource :department, through: :school, find_by: :uuid
  load_and_authorize_resource through: :department, shallow: true, find_by: :uuid
  before_filter :load_new_path, only: [:index]
  before_filter :setup_teacher, only: [:new]

  private
  def load_new_path
    @new_path = @department.present? ? new_department_course_path(@department) : new_course_path
  end
  
  def setup_teacher
    @course.build_teacher(school_id: current_user.school_id) if @course.teacher.blank?
  end
end

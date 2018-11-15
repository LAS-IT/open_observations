class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.string :section
      t.string :semester
      t.references :teacher
      t.references :department

      t.timestamps
    end
    add_index :courses, :teacher_id
    add_index :courses, :department_id
  end
end

class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.references :course
      t.references :teacher
      t.references :user
      t.date :observed_on
      t.string :period
      t.integer :number_of_students
      t.boolean :observer_confidence, default: false
      t.text :feedback

      t.timestamps
    end
    add_index :observations, :course_id
    add_index :observations, :teacher_id
    add_index :observations, [:course_id, :teacher_id]
    add_index :observations, :user_id
  end
end

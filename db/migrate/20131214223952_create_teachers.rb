class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :first_name
      t.string :last_name
      t.references :school
      t.references :user
      t.string :registration_code

      t.timestamps
    end
    add_index :teachers, :school_id
    add_index :teachers, :user_id
    add_index :teachers, [:school_id, :registration_code], unique: true
  end
end

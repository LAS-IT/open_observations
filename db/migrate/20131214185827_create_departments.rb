class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.text :description
      t.references :program
      t.integer :courses_count, default: 0

      t.timestamps
    end
    add_index :departments, :program_id
    add_index :departments, [:program_id, :name], unique: true
  end
end

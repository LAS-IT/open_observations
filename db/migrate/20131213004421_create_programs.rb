class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :title
      t.references :school
      t.integer :courses_count, default: 0

      t.timestamps
    end
    add_index :programs, :school_id
  end
end

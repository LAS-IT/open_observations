class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :town
      t.string :country
      t.datetime :deleted_at
      t.string :teacher_code
      t.string :observer_code

      t.timestamps
    end
  end
end

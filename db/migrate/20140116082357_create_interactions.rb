class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.references :observation
      t.integer :teacher, null: false
      t.integer :students, null: false
      t.integer :grouping, null: false
      t.integer :topic, null: false
      t.boolean :using_technology, default: false
      t.integer :on_task, null: false
      t.integer :minute, null: false
      t.text :note

      t.timestamps
    end
    add_index :interactions, :observation_id
  end
end

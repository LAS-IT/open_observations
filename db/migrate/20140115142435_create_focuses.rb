class CreateFocuses < ActiveRecord::Migration
  def change
    create_table :focuses do |t|
      t.string :name
      t.boolean :active, default: true
      t.references :school

      t.timestamps
    end
    add_index :focuses, :school_id
    add_index :focuses, :active
  end
end

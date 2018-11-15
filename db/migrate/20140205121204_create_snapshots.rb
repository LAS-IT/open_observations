class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.references :interaction
      t.attachment :media
      t.text :note

      t.timestamps
    end
    add_index :snapshots, :interaction_id
  end
end

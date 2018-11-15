class CreateObservationFocuses < ActiveRecord::Migration
  def change
    create_table :observation_focuses do |t|
      t.references :observation
      t.references :focus

      t.timestamps
    end
    add_index :observation_focuses, :observation_id
    add_index :observation_focuses, :focus_id
  end
end

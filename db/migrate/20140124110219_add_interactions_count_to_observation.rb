class AddInteractionsCountToObservation < ActiveRecord::Migration
  def change
    add_column :observations, :interactions_count, :integer, default: 0
  end
end

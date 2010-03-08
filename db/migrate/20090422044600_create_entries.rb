class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :feature_id, :default => 0, :null => false
      t.integer :role_id, :default => 0, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end

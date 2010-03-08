class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.integer :role_id, :default => 0, :null => false
      t.integer :user_id, :default => 0, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end

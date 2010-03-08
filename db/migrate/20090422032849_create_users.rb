class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :default_group_id
      t.string :name, :null => false
      t.string :full_name
      t.string :email
      t.string :hashed_password
      t.string :salt
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

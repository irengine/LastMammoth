class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string :scope, :null => false
      t.string :klass, :null => false, :default => "String"
      t.string :key, :null => false
      t.string :value, :null => false
      t.string :mode, :null => false, :default => "active"
      t.integer :position
      
      t.timestamps
    end
  end
  
  
  def self.down
    drop_table :resources
  end
end

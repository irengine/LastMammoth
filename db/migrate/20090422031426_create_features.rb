class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table :features do |t|
      t.string :name, :null => false
      t.string :controller_name, :null => false
      t.string :action_name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :features
  end
end

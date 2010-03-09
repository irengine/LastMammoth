class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table :features do |t|
      t.string :name, :null => false
      t.string :controller_name
      t.string :action_name
      t.string :code_scope
      t.integer :level
      t.string :action
      t.string :uri

      t.timestamps
    end
  end

  def self.down
    drop_table :features
  end
end

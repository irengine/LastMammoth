class CreateCustomQueries < ActiveRecord::Migration
  def self.up
    create_table :custom_queries do |t|
      # the caption will get from locals file
      t.string :name, :null => false;
      t.text :syntax, :null => false
      t.string :action
      t.string :summary
      t.integer :page, :default => 20

      t.timestamps
    end
  end

  def self.down
    drop_table :custom_queries
  end
end

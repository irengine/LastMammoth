class CreateCustomQueryParameters < ActiveRecord::Migration
  def self.up
    create_table :custom_query_parameters do |t|
      t.integer :query_id, :null => false
      # the caption will get from locals file
      t.string :name, :null => false
      t.string :flag
      t.string :syntax
      t.string :code
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :custom_query_parameters
  end
end

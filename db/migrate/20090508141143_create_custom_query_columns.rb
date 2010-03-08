class CreateCustomQueryColumns < ActiveRecord::Migration
  def self.up
    create_table :custom_query_columns do |t|
      t.integer :query_id, :null => false
      # the caption will get from locals file
      t.string :name
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :custom_query_columns
  end
end

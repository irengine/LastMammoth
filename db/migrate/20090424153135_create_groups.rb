class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :root_id
      t.string :type
      t.integer :lv

      t.string :name
      t.string :description
      t.string :contacts
      t.string :address

      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end

class AddContactInfoToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :begin_date, :date
    add_column :groups, :end_date, :date
    add_column :groups, :quantity, :integer
  end

  def self.down
    remove_column :groups, :begin_date
    remove_column :groups, :end_date
    remove_column :groups, :quantity
  end
end

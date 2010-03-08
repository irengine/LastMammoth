class CreateEmployeeCloths < ActiveRecord::Migration
  def self.up
    create_table :employee_cloths do |t|
      t.integer :employee_id
      t.date :get_date
      t.string :get_type
      t.string :get_model
      t.integer :get_quantity
      
      t.timestamps
    end
  end

  def self.down
    drop_table :employee_cloths
  end
end

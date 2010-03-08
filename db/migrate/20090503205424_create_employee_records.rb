class CreateEmployeeRecords < ActiveRecord::Migration
  def self.up
    create_table :employee_records do |t|
      t.integer :employee_id
      t.date :record_date
      t.string :reason
      t.string :result
      
      t.timestamps
    end
  end

  def self.down
    drop_table :employee_records
  end
end

class AddWorkingYearsToEmployee < ActiveRecord::Migration
  def self.up
    add_column :employees, :residence_address, :string
    add_column :employees, :contract_begin_date, :date
    add_column :employees, :contract_end_date, :date
    add_column :employees, :total_working_years, :integer
            
#    t.string :residence_address           #户口地址
#    t.integer :total_working_years        #连续工龄
  end

  def self.down
    remove_column :employees, :residence_address
    remove_column :employees, :contract_begin_date
    remove_column :employees, :contract_end_date
    remove_column :employees, :total_working_years
  end
end

class AddWorkingYearsToEmployee < ActiveRecord::Migration
  def self.up
    add_column :employees, :residence_address, :string
    add_column :employees, :current_working_years, :integer
    add_column :employees, :total_working_years, :integer
            
#    t.string :residence_address           #户口地址
#    t.integer :current_working_years      #本公司工齡
#    t.integer :total_working_years        #连续工齡
  end

  def self.down
    remove_column :employees, :residence_address
    remove_column :employees, :current_working_years
    remove_column :employees, :total_working_years
  end
end

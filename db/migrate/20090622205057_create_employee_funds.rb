class CreateEmployeeFunds < ActiveRecord::Migration
  def self.up
    create_table :employee_funds do |t|
      t.integer :employee_id

      t.integer :fund_type_id               #缴金类型
      t.date :fund_date                     #缴金日期
      t.integer :fund_address_id            #缴金街道
      t.timestamps
    end
  end

  def self.down
    drop_table :employee_funds
  end
end

class CreateEmployeeStatuses < ActiveRecord::Migration
  def self.up
    create_table :employee_statuses do |t|
      t.integer :employee_id
      t.integer :branch_id
      t.integer :group_id
      t.integer :team_id
      t.string :flag

      t.timestamps
    end
  end

  def self.down
    drop_table :employee_statuses
  end
end

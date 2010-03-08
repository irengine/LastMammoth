class CreateWorkingExperiences < ActiveRecord::Migration
  def self.up
    create_table :working_experiences do |t|
      t.integer :employee_id

      t.date :begin_date
      t.date :end_date
      t.string :company_name
      t.string :job_title

      t.timestamps
    end
  end

  def self.down
    drop_table :working_experiences
  end
end

class CreateJobHistories < ActiveRecord::Migration
  def self.up
    create_table :job_histories do |t|
      t.integer :employee_id

      t.string :history_type

      t.integer :source_branch_id
      t.integer :source_group_id
      t.integer :source_site_id
      t.string :source_job_name
      t.string :source_job_title
      t.date :source_begin_date
      t.date :source_end_date
      t.text :source_remark

      t.integer :target_branch_id
      t.integer :target_group_id
      t.integer :target_site_id
      t.string :target_job_name
      t.string :target_job_title
      t.date :target_begin_date
      t.date :target_end_date
      t.text :target_remark

      t.timestamps
    end
  end

  def self.down
    drop_table :job_histories
  end
end

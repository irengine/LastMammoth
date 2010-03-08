class EmployeeStatus < ActiveRecord::Base
  belongs_to :employee
  belongs_to :branch, :class_name => "Group", :foreign_key => "branch_id"
  belongs_to :group, :class_name => "Group", :foreign_key => "group_id"
  belongs_to :team, :class_name => "Group", :foreign_key => "team_id"
end

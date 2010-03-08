class Group < ActiveRecord::Base
  GROUP_TYPES = ['总部', '单位', '部门/中队', '驻点']

  acts_as_nested_set

  has_many :users
  
  has_many :employees_in_branch, :class_name => "EmployeeStatus", :foreign_key => "branch_id"
  has_many :employees_in_group, :class_name => "EmployeeStatus", :foreign_key => "group_id"
  has_many :employees_in_team, :class_name => "EmployeeStatus", :foreign_key => "team_id"

  named_scope :companies, :conditions => ["lv < 4"]

  def self.get_type(i)
    GROUP_TYPES[i]
  end

  def self.types
    ts = []
    ts << [I18n.t("UnitCompany"), "UnitCompany"]
    ts << [I18n.t("UnitBranch"), "UnitBranch"]
    ts << [I18n.t("UnitGroup"), "UnitGroup"]
    ts << [I18n.t("UnitTeam"), "UnitTeam"]
  end
end

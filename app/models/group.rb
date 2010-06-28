class Group < ActiveRecord::Base
  validates_presence_of :name #:contacts, :address

  GROUP_TYPES = ['总部', '单位', '部门/中队', '驻点']

  acts_as_nested_set

  has_many :users
  
  has_many :employees_in_branch, :class_name => "EmployeeStatus", :foreign_key => "branch_id"
  has_many :employees_in_group, :class_name => "EmployeeStatus", :foreign_key => "group_id"
  has_many :employees_in_team, :class_name => "EmployeeStatus", :foreign_key => "team_id"

  named_scope :companies, :conditions => ["lv < 4"]

  # Tree support
  Group.include_root_in_json = false

  def self.find_children(start_id = nil)
    children = start_id.to_i == 0 ? Group.roots : find(start_id).children
    children.select {|c| !c.lv.nil?}
#    puts children.class
  end

  def text
    name
  end

  def leaf
    unknown? || children_count == 0
  end

  def to_json_with_leaf(options = {})
    to_json_without_leaf(options.merge(:only => [:id, :text, :leaf], :methods => [:leaf, :text]))
  end

  alias_method_chain :to_json, :leaf
  # End tree support

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

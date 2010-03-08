class UnitBranch < Group
  has_one :external, :class_name => "UnitExternal", :foreign_key => "parent_id"
  has_one :idel, :class_name => "UnitIdel", :foreign_key => "parent_id"
end
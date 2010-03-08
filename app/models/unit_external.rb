class UnitExternal < Group
  belongs_to :branch, :class_name => "UnitBranch", :foreign_key => "parent_id"
end

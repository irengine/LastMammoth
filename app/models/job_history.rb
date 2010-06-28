class JobHistory < ActiveRecord::Base
  belongs_to :employee

  belongs_to :source_branch, :class_name => "Group", :foreign_key => "source_branch_id"
  belongs_to :source_group, :class_name => "Group", :foreign_key => "source_group_id"
  belongs_to :source_team, :class_name => "Group", :foreign_key => "source_site_id"

  belongs_to :target_branch, :class_name => "Group", :foreign_key => "target_branch_id"
  belongs_to :target_group, :class_name => "Group", :foreign_key => "target_group_id"
  belongs_to :target_team, :class_name => "Group", :foreign_key => "target_site_id"

  def self.types
    ts = []
    ts << ["上岗", 'start']
    ts << ["离岗", 'stop']
    ts << ["待岗", 'idel']
    ts << ["调岗", 'change']
  end
end

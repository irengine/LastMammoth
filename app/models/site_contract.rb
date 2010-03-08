class SiteContract < ActiveRecord::Base
  belongs_to :site, :class_name => "Group", :foreign_key => "site_id"
end

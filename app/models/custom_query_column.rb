class CustomQueryColumn < ActiveRecord::Base
  acts_as_list
  
  belongs_to :query, :class_name => 'CustomQuery', :foreign_key => 'query_id'
end

class CustomQuery < ActiveRecord::Base
  has_many :parameters, :class_name => 'CustomQueryParameter', :foreign_key => 'query_id', :order => 'position'
  has_many :columns, :class_name => 'CustomQueryColumn', :foreign_key => 'query_id', :order => 'position'
end

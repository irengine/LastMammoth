class Feature < ActiveRecord::Base
  has_many :entries, :dependent => :delete_all
  has_many :roles, :through => :entries
end

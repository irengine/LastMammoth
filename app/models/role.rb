class Role < ActiveRecord::Base
  has_many :permissions, :dependent => :delete_all
  has_many :users, :through => :permissions

  has_many :entries, :dependent => :delete_all
  has_many :features, :through => :entries
end

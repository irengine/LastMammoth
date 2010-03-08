class Entry < ActiveRecord::Base
  belongs_to :feature
  belongs_to :role
end

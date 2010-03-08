class EmployeeCloth < ActiveRecord::Base
  belongs_to :employee

  validates_presence_of :get_quantity
  validates_numericality_of :get_quantity
end

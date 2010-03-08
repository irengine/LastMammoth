class EmployeeFund < ActiveRecord::Base
  belongs_to :employee

  belongs_to :fund_type, :class_name => "Resource", :foreign_key => "fund_type_id" ,:conditions => "scope = 'code.fund_type'"
  belongs_to :fund_address, :class_name => "Resource", :foreign_key => "fund_address_id" ,:conditions => "scope = 'code.fund_address'"
end

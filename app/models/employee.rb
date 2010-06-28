class Employee < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 20
  
  has_one :branch, :through => :status
  has_one :group, :through => :status
  has_one :team, :through => :status
  has_one :status, :class_name => "EmployeeStatus", :foreign_key => "employee_id"

  belongs_to :default_group, :class_name => "Group", :foreign_key => "default_group_id"

  has_one :photo, :dependent => :destroy

  has_many :working_experiences, :class_name => "WorkingExperience", :foreign_key => "employee_id", :dependent => :destroy

  has_many :job_histories, :class_name => "JobHistory", :foreign_key => "employee_id"

  has_many :records, :class_name => "EmployeeRecord", :foreign_key => "employee_id"
  has_many :cloths, :class_name => "EmployeeCloth", :foreign_key => "employee_id"
  has_many :funds, :class_name => "EmployeeFund", :foreign_key => "employee_id"

  belongs_to :gender, :class_name => "Resource", :foreign_key => "gender_id" ,:conditions => "scope = 'code.gender'"
  belongs_to :political_status, :class_name => "Resource", :foreign_key => "political_status_id" ,:conditions => "scope = 'code.political_status'"
  belongs_to :educational_attainments, :class_name => "Resource", :foreign_key => "educational_attainments_id" ,:conditions => "scope = 'code.educational_attainments'"
  belongs_to :person_type, :class_name => "Resource", :foreign_key => "person_type_id" ,:conditions => "scope = 'code.person_type'"
  belongs_to :employee_type, :class_name => "Resource", :foreign_key => "employee_type_id" ,:conditions => "scope = 'code.employee_type'"
  belongs_to :fund_type, :class_name => "Resource", :foreign_key => "fund_type_id" ,:conditions => "scope = 'code.fund_type'"
  belongs_to :fund_address, :class_name => "Resource", :foreign_key => "fund_address_id" ,:conditions => "scope = 'code.fund_address'"
  belongs_to :training_status, :class_name => "Resource", :foreign_key => "training_status_id" ,:conditions => "scope = 'code.training_status'"

  named_scope :in_group, lambda { |group|
    { :conditions => { :default_group_id => group } }
  }
  
  validates_presence_of :id_card_number,                     #身份证号
  :name,                                #姓名
  :gender,                              #性别
#  :license_number,                      #从业号
#  :employee_number,                     #工号
  :height,                              #身高
  :mobile_number,                       #手机
  :political_status,                    #政治面貌
  :educational_attainments,             #文化程度
  :person_type,                         #人员性质 PersonTypes
  :permanent_residence,                 #户口所属区
  :employee_type,                       #用工性质 EmployeeTypes
  :home_address ,                       #家庭住址
  :residence_address                    #户口地址

  validates_uniqueness_of :id_card_number

  validates_format_of :id_card_number, :with => /\A([1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3})|([1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[A-Z]))\Z/

  validates_numericality_of :license_number, :employee_number, :height, :total_working_years

  def before_save
    self.birthdate = get_birthdate_from_id_card_number
  end


  def self.create_employee(employee, photo, working_experiences)
    status = EmployeeStatus.new
    status.branch = employee.default_group
    status.group = employee.default_group.external
    status.employee = employee
    status.flag = 0
    
    begin
      Employee.transaction do
        if !photo.nil?
          photo.employee = employee
          photo.save!
        end
        working_experiences.each do |w|
          w.employee = employee
          w.save!
        end
        employee.save!
        status.save!
        true
      end
    rescue
      false
    end
  end

  def self.update_employee(attributes, employee, working_experiences)
    begin
      Employee.transaction do
        employee.update_attributes!(attributes)
        employee.working_experiences.clear
        working_experiences.each do |w|
          w.employee = employee
          w.save!
        end
      end
    rescue
      false
    end
  end

  def self.upload_photo(employee, photo)
    begin
      Employee.transaction do
        if !photo.nil?
          employee.photo.destroy if employee.photo
          photo.employee = employee
          photo.save!
        end
        true
      end
    rescue
      false
    end
  end

  private

  def get_birthdate_from_id_card_number
    case id_card_number.length
    when 15
      convert_string_to_date('19' + id_card_number[6,2] + '-' + id_card_number[8,2] + '-' + id_card_number[10,2])
    when 18
      convert_string_to_date(id_card_number[6,4] + '-' + id_card_number[10,2] + '-' + id_card_number[12,2])
    else
      '1980-01-01'
    end
  end

  def convert_string_to_date(s)
    s.to_date()
  end
end

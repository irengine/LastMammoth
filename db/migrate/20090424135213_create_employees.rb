class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.integer :default_group_id
      t.string :name                        #姓名
      t.integer :gender_id                  #性别
      t.date :birthdate                     #出生年月
      t.string :id_card_number              #身份证号

      t.string :license_number              #从业号
      t.string :employee_number             #工号
      t.integer :height                     #身高
      t.string :phone_number                #电话
      t.string :mobile_number               #手机
      t.integer :political_status_id        #政治面貌
      t.integer :educational_attainments_id #文化程度
      t.integer :person_type_id             #人员性质
      t.boolean :is_demobilized             #复员军人
      t.string :permanent_residence         #户口所属区
      t.integer :employee_type_id           #用工性质
      t.string :home_address                #家庭住址

      t.integer :fund_type_id               #缴金类型
      t.date :fund_date                     #缴金日期
      t.integer :fund_address_id            #缴金街道
      t.integer :training_status_id         #培训情况

      t.text :remarks                       #备注
      t.timestamps
    end
  end

  def self.down
    drop_table :employees
  end
end

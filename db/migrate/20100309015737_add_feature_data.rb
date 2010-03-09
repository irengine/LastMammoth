class AddFeatureData < ActiveRecord::Migration
  def self.up
        Feature.create :name => "系统管理", :level => 100
        Feature.create :name => "组织管理", :controller_name => 'groups', :action_name => 'custom', :level => 110
        Feature.create :name => "用户管理", :controller_name => 'users', :level => 120
        Feature.create :name => "角色管理", :controller_name => 'role', :action_name => 'list_entries', :level => 130
        Feature.create :name => "权限管理", :controller_name => 'user', :action_name => 'list_permissions', :level => 140

        Feature.create :name => "人员管理", :level => 200
        Feature.create :name => "人员信息管理", :controller_name => 'employees', :action_name => 'custom', :level => 210
        Feature.create :name => "人事异动管理", :controller_name => 'jobs', :action_name => 'custom', :level => 220
        Feature.create :name => "服装管理", :controller_name => 'employees', :action_name => 'asset', :level => 230
        Feature.create :name => "奖惩管理", :controller_name => 'employees', :action_name => 'asset', :level => 240
        Feature.create :name => "缴金管理", :controller_name => 'employees', :action_name => 'asset', :level => 250

        Feature.create :name => "合同管理", :level => 300
        Feature.create :name => "驻点合同管理", :controller_name => 'site_contracts', :level => 310

        Feature.create :name => "报表管理", :level => 400
        Feature.create :name => "组织机构一览", :controller_name => 'groups', :level => 410

        Feature.create :name => "代码管理", :level => 500
        Feature.create :name => "政治面貌", :controller_name => 'resources', :code_scope => 'political_status', :level => 505
        Feature.create :name => "文化程度", :controller_name => 'resources', :code_scope => 'educational_attainments', :level => 510
        Feature.create :name => "人员性质", :controller_name => 'resources', :code_scope => 'person_type', :level => 515
        Feature.create :name => "用工性质", :controller_name => 'resources', :code_scope => 'employee_type', :level => 520
        Feature.create :name => "缴金类型", :controller_name => 'resources', :code_scope => 'fund_type', :level => 525
        Feature.create :name => "缴金街道", :controller_name => 'resources', :code_scope => 'fund_address', :level => 530
        Feature.create :name => "培训情况", :controller_name => 'resources', :code_scope => 'training_status', :level => 535
        Feature.create :name => "岗位", :controller_name => 'resources', :code_scope => 'job_name', :level => 540
        Feature.create :name => "职务", :controller_name => 'resources', :code_scope => 'job_title', :level => 545
        Feature.create :name => "服装类别", :controller_name => 'resources', :code_scope => 'clothes_type', :level => 550
        Feature.create :name => "服装型号", :controller_name => 'resources', :code_scope => 'clothes_model', :level => 555

        Feature.create :name => "查询", :level => 600
        Feature.create :name => "人员查询", :controller_name => 'query', :action_name => 'employees', :level => 610

        r = Role.find(1)
        r.features.delete_all
        r.features << Feature.find(:all)
        r.save
  end

  def self.down
    Feature.delete_all
  end
end

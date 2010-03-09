class AddDefaultUserAndRole < ActiveRecord::Migration
  def self.up
    r = Role.create(:name => "系统管理员")
    Role.create(:name => "管理员")
    Role.create(:name => "主管")
    Role.create(:name => "装备管理")
    Role.create(:name => "人事专员")
    Role.create(:name => "访客")
    Role.create(:name => "业务员")
    Role.create(:name => "督察员")

    User.create(:name => 'sysAdmin',
      :full_name => 'System Administrator',
      :email => 'sysAdmin@taoware.com',
      :password=> 'password',
      :roles => [r]
    )
  end

  def self.down
    User.delete_all
    Role.delete_all
  end
end

class AddGroupData < ActiveRecord::Migration
  def self.up
    root = UnitCompany.create(:name=>'浦东保安服务总公司', :lv=>0, :type=>'UnitCompany')

    l = UnitBranch.create(:name=>'总公司', :lv=>2, :type=>'UnitBranch')
    l.move_to_child_of(root)

    external = UnitExternal.create(:name=>'离岗')
    external.move_to_child_of(l)
    idel = UnitIdel.create(:name=>'待岗')
    idel.move_to_child_of(l)

    l1 = UnitGroup.create(:name=>'人事部', :lv=>4, :type=>'UnitBranch')
    l1.move_to_child_of(l)

    l2 = UnitGroup.create(:name=>'财务部', :lv=>4, :type=>'UnitBranch')
    l2.move_to_child_of(l)

    l3 = UnitGroup.create(:name=>'办公室', :lv=>4, :type=>'UnitBranch')
    l3.move_to_child_of(l)

    l4 = UnitGroup.create(:name=>'保安部', :lv=>4, :type=>'UnitBranch')
    l4.move_to_child_of(l)

    l5 = UnitBranch.create(:name=>'技防分公司', :lv=>2, :type=>'UnitBranch')
    l5.move_to_child_of(root)

    l6 = UnitBranch.create(:name=>'培训中心', :lv=>2, :type=>'UnitBranch')
    l6.move_to_child_of(root)

    l7 = UnitBranch.create(:name=>'停车中心', :lv=>2, :type=>'UnitBranch')
    l7.move_to_child_of(root)

    c1 = UnitBranch.create(:name=>'人防一分公司', :lv=>2, :type=>'UnitBranch')
    c1.move_to_child_of(root)

    external = UnitExternal.create(:name=>'离岗')
    external.move_to_child_of(c1)
    idel = UnitIdel.create(:name=>'待岗')
    idel.move_to_child_of(c1)

    cc11 = UnitGroup.create(:name=>'综合部', :lv=>4, :type=>'UnitBranch')
    cc11.move_to_child_of(c1)

    cc12 = UnitGroup.create(:name=>'管理部', :lv=>4, :type=>'UnitBranch')
    cc12.move_to_child_of(c1)

    cc13 = UnitGroup.create(:name=>'业务部', :lv=>4, :type=>'UnitBranch')
    cc13.move_to_child_of(c1)

    c2 = UnitBranch.create(:name=>'人防二分公司', :lv=>2, :type=>'UnitBranch')
    c2.move_to_child_of(root)

    external = UnitExternal.create(:name=>'离岗')
    external.move_to_child_of(c2)
    idel = UnitIdel.create(:name=>'待岗')
    idel.move_to_child_of(c2)

    cc21 = UnitGroup.create(:name=>'综合部', :lv=>4, :type=>'UnitBranch')
    cc21.move_to_child_of(c2)

    cc22 = UnitGroup.create(:name=>'管理部', :lv=>4, :type=>'UnitBranch')
    cc22.move_to_child_of(c2)

    cc23 = UnitGroup.create(:name=>'业务部', :lv=>4, :type=>'UnitBranch')
    cc23.move_to_child_of(c2)

    c3 = UnitBranch.create(:name=>'人防三分公司', :lv=>2, :type=>'UnitBranch')
    c3.move_to_child_of(root)

    external = UnitExternal.create(:name=>'离岗')
    external.move_to_child_of(c3)
    idel = UnitIdel.create(:name=>'待岗')
    idel.move_to_child_of(c3)

    cc31 = UnitGroup.create(:name=>'综合部', :lv=>4, :type=>'UnitBranch')
    cc31.move_to_child_of(c3)

    cc32 = UnitGroup.create(:name=>'管理部', :lv=>4, :type=>'UnitBranch')
    cc32.move_to_child_of(c3)

    cc33 = UnitGroup.create(:name=>'业务部', :lv=>4, :type=>'UnitBranch')
    cc33.move_to_child_of(c3)
  end

  def self.down
    Group.delete_all
  end
end

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "create group structure" do
    pdss = UnitCompany.create(:name => "PDSS")

    branch1 = UnitBranch.create(:name => "Branch 1")
    branch1.move_to_child_of(pdss)

    branch1_external = UnitExternal.create(:name => "Branch 1 External")
    branch1_external.move_to_child_of(branch1)

    branch1_idel = UnitExternal.create(:name => "Branch 1 Idel")
    branch1_idel.move_to_child_of(branch1)

    group1 = UnitGroup.create(:name => "b1 group1");
    group1.move_to_child_of(branch1)

    team1 = UnitTeam.create(:name => "b1 group1 team1");
    team1.move_to_child_of(group1)


    gs = Group.find(:all)

    puts gs.length
    
    gs.each do |g|
      puts "#{g.type}: #{g.name}"
    end

    r = Group.root
    puts r.all_children_count
    
    gs = r.full_set
    gs.each do |g|
      puts "#{g.type}: #{g.name}"
    end
  end
end

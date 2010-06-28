class AddNewResourceData < ActiveRecord::Migration
  def self.up

    # 人员性质
    Resource.create(:scope => 'code.person_type', :key => '失业', :value => '失业')
    Resource.create(:scope => 'code.person_type', :key => '下岗', :value => '下岗')
    Resource.create(:scope => 'code.person_type', :key => '协保', :value => '协保')
    Resource.create(:scope => 'code.person_type', :key => '征地-一保障', :value => '征地-一保障')
    Resource.create(:scope => 'code.person_type', :key => '征地-二保障', :value => '征地-二保障')
    Resource.create(:scope => 'code.person_type', :key => '退休', :value => '退休')
    Resource.create(:scope => 'code.person_type', :key => '外省市', :value => '外省市')
    Resource.create(:scope => 'code.person_type', :key => '农民', :value => '农民')

    # 用工性质
    Resource.create(:scope => 'code.employee_type', :key => '在编-事编', :value => '在编-事编')
    Resource.create(:scope => 'code.employee_type', :key => '在编-合同制', :value => '在编-合同制')
    Resource.create(:scope => 'code.employee_type', :key => '在编-农民合同制', :value => '在编-农民合同制')
    Resource.create(:scope => 'code.employee_type', :key => '在编-征地工', :value => '在编-征地工')
    Resource.create(:scope => 'code.employee_type', :key => '非编', :value => '非编')
    Resource.create(:scope => 'code.employee_type', :key => '聘用', :value => '聘用')
    Resource.create(:scope => 'code.employee_type', :key => '干警', :value => '干警')
    Resource.create(:scope => 'code.employee_type', :key => '其他', :value => '其他')

    # 培训情况
    Resource.create(:scope => 'code.training_status', :key => '保安上岗证', :value => '保安上岗证')
    Resource.create(:scope => 'code.training_status', :key => '消防上岗证', :value => '消防上岗证')
  end

  def self.down
  end
end

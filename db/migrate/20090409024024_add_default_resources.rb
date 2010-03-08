class AddDefaultResources < ActiveRecord::Migration
  def self.up
    # 性别: 男 女
    Resource.create(:scope => 'code.gender', :key => '男', :value => '男')
    Resource.create(:scope => 'code.gender', :key => '女', :value => '女')

    # 政治面貌: 党员 团员 其他
    Resource.create(:scope => 'code.political_status', :key => '无', :value => '无')
    Resource.create(:scope => 'code.political_status', :key => '党员', :value => '党员')
    Resource.create(:scope => 'code.political_status', :key => '团员', :value => '团员')
    Resource.create(:scope => 'code.political_status', :key => '其他', :value => '其他')

    # 文化程度: 大学本科 大学专科 高中 技校 初中 初中以下
    Resource.create(:scope => 'code.educational_attainments', :key => '无', :value => '无')
    Resource.create(:scope => 'code.educational_attainments', :key => '大学本科', :value => '大学本科')
    Resource.create(:scope => 'code.educational_attainments', :key => '大学专科', :value => '大学专科')
    Resource.create(:scope => 'code.educational_attainments', :key => '高中', :value => '高中')
    Resource.create(:scope => 'code.educational_attainments', :key => '技校', :value => '技校')
    Resource.create(:scope => 'code.educational_attainments', :key => '初中', :value => '初中')
    Resource.create(:scope => 'code.educational_attainments', :key => '初中以下', :value => '初中以下')

    # 人员性质
    Resource.create(:scope => 'code.person_type', :key => '无', :value => '无')

    # 用工性质
    Resource.create(:scope => 'code.employee_type', :key => '无', :value => '无')

    # 缴金类型
    Resource.create(:scope => 'code.fund_type', :key => '无', :value => '无')

    # 缴金街道
    Resource.create(:scope => 'code.fund_address', :key => '无', :value => '无')

    # 培训情况
    Resource.create(:scope => 'code.training_status', :key => '无', :value => '无')

    # 岗位
    Resource.create(:scope => 'code.job_name', :key => '无', :value => '无')

    # 职务
    Resource.create(:scope => 'code.job_title', :key => '无', :value => '无')

    # 服装类别
    Resource.create(:scope => 'code.clothes_type', :key => '无', :value => '无')

    # 服装型号
    Resource.create(:scope => 'code.clothes_model', :key => '无', :value => '无')
  end

  def self.down
    Resource.delete_all
  end
end

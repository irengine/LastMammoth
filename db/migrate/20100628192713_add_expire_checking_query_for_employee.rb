class AddExpireCheckingQueryForEmployee < ActiveRecord::Migration
  def self.up
    q = CustomQuery.create(:name => 'employee_expired_query', :syntax => 'select employees.id, (case employee_statuses.flag when 0 then \'离岗\' when 1 then \'在岗\' when 2 then \'待岗\' end) as \'状态\', g.name as \'部门/中队\', t.name as \'岗点\', employees.name as \'姓名\', id_card_number as \'身份证\', license_number as \'从业号\', employee_number as \'工号\' from employees inner join employee_statuses on employees.id = employee_statuses.employee_id left outer join groups as g on employee_statuses.group_id = g.id left outer join groups as t on employee_statuses.group_id = t.id where employees.default_group_id = __group', :action => '/resources/results')

    CustomQueryParameter.create(:query => q, :name => 'employee.expired_days', :flag => 'string', :syntax => 'datediff(curdate(), employees.contract_end_date) <= %s')

    q1 = CustomQuery.create(:name => 'group_expired_query', :syntax => 'select groups.id, concat((case when parent.name is null then \'\' else concat(parent.name, \'-\') end), groups.name) as \'名称\', groups.type as \'类型\' from groups left outer join groups as parent on groups.parent_id = parent.id where groups.lv is not null and groups.type = \'UnitTeam\'', :action => '/resources/results')

    CustomQueryParameter.create(:query => q1, :name => 'group.expired_days', :flag => 'string', :syntax => 'datediff(curdate(), groups.end_date) <= %s')
  end

  def self.down
    q = CustomQuery.find_by_name('employee_expired_query')
    q.delete unless q.nil?

    q1 = CustomQuery.find_by_name('group_expired_query')
    q1.delete unless q1.nil?
  end
end

class AddDefaultQueries < ActiveRecord::Migration
  def self.up
    q1 = CustomQuery.create(:name => 'group_query', :syntax => 'select groups.id, concat((case when parent.name is null then \'\' else concat(parent.name, \'-\') end), groups.name) as \'名称\', groups.type as \'类型\' from groups left outer join groups as parent on groups.parent_id = parent.id where groups.lv is not null', :action => '/groups/results')

    CustomQueryParameter.create(:query => q1, :name => 'group.type', :flag => 'list', :syntax => 'groups.type = \'%s\'', :code => 'Group.types')
    CustomQueryParameter.create(:query => q1, :name => 'group.name', :flag => 'string', :syntax => 'groups.name like \'%%%s%%\'')
    CustomQueryParameter.create(:query => q1, :name => 'group.lft', :flag => 'hidden', :syntax => 'groups.lft >= %d')
    CustomQueryParameter.create(:query => q1, :name => 'group.rgt', :flag => 'hidden', :syntax => 'groups.lft <= %d')

    q2 = CustomQuery.create(:name => 'employee_query', :syntax => 'select employees.id, (case employee_statuses.flag when 0 then \'离岗\' when 1 then \'在岗\' when 2 then \'待岗\' end) as \'状态\', g.name as \'部门/中队\', t.name as \'岗点\', employees.name as \'姓名\', id_card_number as \'身份证\', license_number as \'从业号\', employee_number as \'工号\' from employees inner join employee_statuses on employees.id = employee_statuses.employee_id left outer join groups as g on employee_statuses.group_id = g.id left outer join groups as t on employee_statuses.group_id = t.id where 1=1', :action => '/employees/results')

    CustomQueryParameter.create(:query => q2, :name => 'employee.group_id', :flag => 'string', :syntax => '(case %d when employee_statuses.branch_id then true when employee_statuses.group_id then true when employee_statuses.team_id then true else false end)')
    CustomQueryParameter.create(:query => q2, :name => 'employee.group_name', :flag => 'string', :syntax => '\'%s\'<>\'\'')
    CustomQueryParameter.create(:query => q2, :name => 'employee.status', :flag => 'list', :syntax => 'employee_statuses.flag = %d', :code => 'EmployeeStatus.flags')
    CustomQueryParameter.create(:query => q2, :name => 'employee.name', :flag => 'string', :syntax => 'employees.name = \'%s\'')
    CustomQueryParameter.create(:query => q2, :name => 'employee.employee_number', :flag => 'string', :syntax => 'employees.employee_number = \'%s\'')
    CustomQueryParameter.create(:query => q2, :name => 'employee.license_number', :flag => 'string', :syntax => 'employees.license_number = \'%s\'')
    CustomQueryParameter.create(:query => q2, :name => 'employee.id_card_number', :flag => 'string', :syntax => 'employees.id_card_number = \'%s\'')
    CustomQueryParameter.create(:query => q2, :name => 'employee.person_type_id', :flag => 'list', :syntax => 'employees.person_type_id = %d', :code => 'Resource.lookup_ids(:person_type)')
    CustomQueryParameter.create(:query => q2, :name => 'employee.fund_type_id', :flag => 'list', :syntax => 'employees.fund_type_id = %d', :code => 'Resource.lookup_ids(:fund_type)')
    CustomQueryParameter.create(:query => q2, :name => 'employee.fund_address_id', :flag => 'list', :syntax => 'employees.fund_address_id = %d', :code => 'Resource.lookup_ids(:fund_address)')
    CustomQueryParameter.create(:query => q2, :name => 'employee.training_status_id', :flag => 'list', :syntax => 'employees.training_status_id = %d', :code => 'Resource.lookup_ids(:training_status)')

    q3 = CustomQuery.create(:name => 'job_query', :syntax => 'select e.id, e.id_card_number as \'身份证\', e.name as \'姓名\', b.name as \'单位\', g.name as \'部门/中队\', t.name as \'驻点\', case when g.type is null then 1 when g.type = \'UnitExternal\' then 1 when g.type=\'UnitIdel\' then 2 else 4 end as \'状态\' from employees as e inner join employee_statuses as s on e.id = s.employee_id left join groups as b on s.branch_id = b.id left join groups as g on s.group_id = g.id left join groups as t on s.team_id = t.id where (s.branch_id = __group or g.type = \'UnitExternal\')', :action => '/jobs/results')

    CustomQueryParameter.create(:query => q3, :name => 'employee.id_card_number', :flag => 'string', :syntax => 'e.id_card_number = \'%s\'')
    CustomQueryParameter.create(:query => q3, :name => 'employee.name', :flag => 'string', :syntax => 'e.name = \'%s\'')

    q4 = CustomQuery.create(:name => 'asset_query', :syntax => 'select id, name as \'姓名\', id_card_number as \'身份证\', license_number as \'从业号\', employee_number as \'工号\', phone_number as \'电话\', mobile_number as \'手机\' from employees where 1=1', :action => '/employees/asset')

    CustomQueryParameter.create(:query => q4, :name => 'employee.name', :flag => 'string', :syntax => 'employees.name = \'%s\'')
    CustomQueryParameter.create(:query => q4, :name => 'employee.id_card_number', :flag => 'string', :syntax => 'employees.id_card_number = \'%s\'')

    q5 = CustomQuery.create(:name => 'employees_query', :syntax => 'select employees.* from employees where 1=1', :action => '/query/employees')

    CustomQueryParameter.create(:query => q5, :name => 'employee.name', :flag => 'string', :syntax => 'employees.name = \'%s\'')
    CustomQueryParameter.create(:query => q5, :name => 'employee.id_card_number', :flag => 'string', :syntax => 'employees.id_card_number = \'%s\'')
    CustomQueryParameter.create(:query => q5, :name => 'employee.min_age', :flag => 'integer', :syntax => '(year(now()) - year(employees.birthdate)) >= %d')
    CustomQueryParameter.create(:query => q5, :name => 'employee.max_age', :flag => 'integer', :syntax => '(year(now()) - year(employees.birthdate)) < %d')
  end

  def self.down
    CustomQueryParameter.delete_all
    CustomQuery.delete_all
  end
end

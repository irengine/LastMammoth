class AddQueryForJobs < ActiveRecord::Migration
  def self.up

    # query name: job_changes_query
    # url: /jobs/custom/job_changes_query
    # result action name: /jobs/query_changes
    # route, controller, string
    q = CustomQuery.create(:name => 'job_changes_query', :syntax => 'select j.id, e.name as \'姓名\', j.created_at as \'异动时间\', (case j.history_type when \'start\' then \'上岗\' when \'change\' then \'调岗\' when \'idel\' then \'待岗\' when \'stop\' then \'离岗\' end) as \'异动类型\', ifnull(sb.name, \'--\') as \'分公司\', ifnull(sg.name, \'--\') as \'部门／中队\', ifnull(st.name, \'--\') as \'驻点\', ifnull(tb.name, \'--\') as \'分公司\', ifnull(tg.name, \'--\') as \'部门／中队\', ifnull(tt.name, \'--\') as \'驻点\' from job_histories j inner join groups sb on j.source_branch_id = sb.id left outer join groups sg on j.source_group_id = sg.id left outer join groups st on j.source_site_id = st.id inner join employees e on j.employee_id = e.id inner join groups tb on j.target_branch_id = tb.id left outer join groups tg on j.target_group_id = tg.id left outer join groups tt on j.target_site_id = tt.id where (sb.id = __group or tb.id = __group)', :action => '/jobs/query_changes')

    CustomQueryParameter.create(:query => q, :name => 'employee.change_type', :flag => 'list', :syntax => 'j.history_type = \'%s\'', :code => 'JobHistory.types')
    CustomQueryParameter.create(:query => q, :name => 'employee.begin_date', :flag => 'string', :syntax => 'j.created_at >= \'%s\'')
    CustomQueryParameter.create(:query => q, :name => 'employee.end_date', :flag => 'string', :syntax => 'j.created_at <= \'%s\'')
  end

  def self.down
    q = CustomQuery.find_by_name('job_changes_query')
    q.delete unless q.nil?
  end
end

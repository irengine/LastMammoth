class AddReportView < ActiveRecord::Migration
  def self.up
    q = CustomQuery.create(:name => 'ages_query', :syntax => 'select Expired, CNT from v_count_ages', :action => '/resources/results')
  end

  def self.down
    q = CustomQuery.find_by_name('ages_query')
    q.delete unless q.nil?
  end
end
